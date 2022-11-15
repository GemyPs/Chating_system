require 'securerandom'

module Api
    module V1
        class ApplicationController < ApiController
            def index
                applications = Application.all
                render json:{
                  status: true,
                  message:'The Applications Fetched!',
                  data:{
                    applications:applications.map{|application| {name:application.name,token:application.token,chats_count:application.chats_count}}
                  }
                }
            end
        
            def update 
                application = Application.find_by(token: params[:application_token])
                unless application
                    render json: { status: false, message: 'Invalid application Token' }
                    return 0
                end
                if application.update(name: params[:name])
                    render json:{
                      status: true,
                      message:'The Application Updated!',
                      data:{
                        name:params[:name],
                        token:params[:application_token],
                        chats_count:application.chats_count
                      }
                    }
                else
                    render json:{
                      status: false,
                      message:'There is an error while updating the application'
                    }
            
                end
            end
            
            def find
                application = Application.find_by(token: params[:application_token])
                unless application
                    render json: { status: false, message: 'Invalid application Token' }
                end
                render json:{
                  status: true,
                  message:'The Application has been fetched!',
                  data:{
                    application: {name:application.name,token:application.token,chats_count:application.chats_count}
                  }
                }
            end

            def create
                object_to_add = { name: params[:name], token: SecureRandom.uuid, chats_count: 0}
                application = Application.new(object_to_add)
        
                if application.save
                    render json:{status: true, message:'The Applications Added!', data:{application:{name:application.name,token:application.token}}}
                else
                    render json:{status: false, message:'There is an error while adding the application', data:{errors:application.errors}}
                end
            end
        end
    end
end