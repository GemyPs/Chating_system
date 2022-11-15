namespace :chat do
    task update_messagescount: :environment do
        chats = Chat.all
            chats.each do |app|
                app.update(messages_count: app.message.count)
        end 
        puts('messages_count updated!')
    end  
  end
  