module Api
    module V1
      class ChatController < ApiController
  
        def update
          application = Application.where(token: params[:application_token]).select(:id).first
          unless application 
            render json: {status: false, message: 'application not found '}
            return 0
          end
          chat_record = application.chat.where(chat_number: params[:chat_number]).first
          unless chat_record
            render json: { status: false, message: 'Wrong chat id!' }
            return 0
          end
          chat_record.name = params[:name]
          if chat_record.save
            render json: { status: true, message: 'The chat Updated!', data: { name: params[:name], chat_number: chat_record.chat_number } }
          else
            render json: { status: false, message: 'There is an error while updating the chat' }
          end
        end
  
        def app_chats
          application = Application.where(token: params[:application_token]).select(:id)
          unless application
            render json: { status: false, message: 'Application Token is invalid!' }
            return 0
          end
          application_chats = Chat.where(application_id: application)
          # return only chat.name and chat.number
          render json: {
            status: true,
            message: 'The chats of the application',
            data: {
              chats: application_chats.map { |chat| { name: chat.name, chat_number: chat.chat_number, messages_count: chat.messages_count } }
            }
          }
        end
  
        def create
          new_chat_number = 0
          application = Application.where(token: params[:application_token]).select(:id).first
          unless application
            render json: { status: false, message: 'The application Token is invalid' }
            return 0
          end
  
          last_chat = Chat.where(application_id: application.id).select(:chat_number).last
          if last_chat
            new_chat_number = last_chat.chat_number
          end
          new_chat = { application_id: application.id, name: params[:name], chat_number: new_chat_number + 1 }
          chat = Chat.new(new_chat)
          if chat.save
            render json: {
              status: true,
              message: 'The chat created!',
              data: {
                chat: {
                  name: chat.name,
                  chat_number: chat.chat_number,
                  message_count: chat.messages_count
                }
              }
            }
          else
            render json: { status: false, message: 'three is an error!', data: { errors: chat.errors } }
          end
        end
      end
    end
  end