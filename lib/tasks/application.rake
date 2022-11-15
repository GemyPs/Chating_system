namespace :application do
    task update_chatscount: :environment do
        applications = Application.all
            applications.each do |app|
                app.update(chats_count: app.chat.count)
        end 
        puts('chats_count updated!')
    end  
  end
  