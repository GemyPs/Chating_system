class HardJob
  include Sidekiq::Job

  def perform(*args)
    obj = JSON.load(args[0])
    chat = Chat.find(obj['chat_id'])
    new_message = Message.new(chat_id: chat.id, message: obj['message'], message_number: obj['message_number'])
    if new_message.save
      puts "Message saved"
    else
      puts "Message not saved"
    end
  end
end
