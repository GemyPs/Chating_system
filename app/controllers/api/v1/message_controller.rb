module Api
    module V1
        class MessageController < ApiController

            def create
                new_message_number = 0
                application = Application.find_by(token: params[:application_token])
                unless application
                    render json: {status: false, message: 'application not found '}
                    return 0
                end
                chat = application.chat.find_by(chat_number: params[:chat_number])
                unless chat
                    render json: { status: false, message: 'Chat not found' }
                    return 0
                end
                
                last_message_number = Message.where(chat_id: chat.id).select(:message_number).last
                if last_message_number
                    new_message_number = last_message_number.message_number
                end
                new_message = { chat_id: chat.id, message: params[:message], message_number: new_message_number+1}
                HardJob.perform_async JSON.dump(new_message)
                #message = Message.new(new_message)
                # if message.save 
                    render json:{
                      status: true,
                      message:'The message created!',
                      data:{
                        message:{
                          chat_number: chat.chat_number,
                          message:new_message[:message],
                          message_number:new_message[:message_number]
                        }
                      }
                    }
                # else
                #     render json:{status: false, message:'threre is an error!', data:{errors:message.errors}}
                # end        
            end

            def update
                application = Application.where(token: params[:application_token]).select(:id)
                unless application 
                    render json: {status: false, message: 'application not fount '}
                    return 0
                end
                chat = application.chat.where(chat_number: params[:chat_number]).first
                unless chat
                    render json: { status: false, message: 'Wrong chat id!' }
                    return 0
                end
                message_record = chat.message.where(message_number: params[:message_number]).first
                message_record.message = params[:message]
                if message_record.save
                    render json:{status: true, message:'The message Updated!', data:{newName:params[:message]}}
                else
                    render json:{status: false, message:'There is an error while updating the message'}
                end
            end

            def chat_messages
                application = Application.where(token: params[:application_token]).select(:id).first
                unless application
                    render json: { status: false, message: 'Application Token is invalid!' }
                    return 0
                end
                messages = application.chat.find_by(chat_number: params[:chat_number]).message.all
                render json:{
                  status: true,
                  message:'The message created!',
                  data: messages.map{|message| {message:message.message, message_number:message.message_number, chat_number:message.chat.chat_number}}
                }
            end


            def search
                application = Application.where(token: params[:application_token]).select(:id).first
                unless application
                    render json: { status: false, message: 'Application Token is invalid!' }
                    return 0
                end
                chat = application.chat.find_by(chat_number: params[:chat_number])
                unless chat
                    render json: { status: false, message: 'Chat not found' }
                end
                messages = chat.message.search(params[:query])
                render json:{
                  status: true,
                  message:'Search result!',
                  data: messages.response['hits']['hits'].map{|message| message['_source']}
                }
            end

        end
    end
end
