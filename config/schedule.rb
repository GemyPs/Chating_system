set :output, "#{path}/log/cron.log" 

every 1.hours do
    rake 'chat:update_messagescount'
    rake 'application:update_chatscount'
end


