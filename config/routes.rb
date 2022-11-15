Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
        scope '/applications' do 
          get '/', to: 'application#index' #DONE
          post '/', to: 'application#create' #DONE
          scope '/:application_token' do
            get '/', to: 'application#find' #DONE   
            patch '/', to: 'application#update' #DONE
            scope '/chats' do
              get '/', to: 'chat#app_chats' #DONE
              post '/', to: 'chat#create' #DONE
              patch '/:chat_number', to: 'chat#update' #DONE
              scope '/:chat_number/messages' do 
                get '/', to: 'message#chat_messages' #DONE
                post '/', to: 'message#create' #DONE
                patch '/:chat_number', to: 'message#update' #DONE
                get '/search', to: 'message#search' #DONE
            end
          end
        end
      end
    end
  end
end