require 'telegram/bot'
require 'dotenv/load'
require 'pry-byebug'

require_relative 'plant'

token = ENV['TITOY_API_KEY']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts "Document #{message.document.nil?}"
    puts "Photo #{message.photo.nil?}"
    puts "Text #{message.text.nil?} #{message.text}"
    puts "Audio #{message.audio.nil?}"
    if !message.text.nil?
      bot.api.send_message(chat_id: message.chat.id, text: "Hey #{message.from.first_name}! Do you want me to help you identify a plant? Send me the photo/file.")
    elsif !message.document.nil?
      binding.pry
      file_path = bot.api.getFile(file_id: message.document.file_id)['result']['file_path']
      tempfile = Down.download("https://api.telegram.org/file/bot#{token}/#{file_path}")

      uploaded = upload(tempfile.path)
      id = uploaded['id']

      suggestion = suggestion(id)
      bot.api.send_message(chat_id: message.chat.id, text: suggestion)
    elsif !message.photo.nil?
      binding.pry
      file_path = bot.api.getFile(file_id: message.photo[2].file_id)['result']['file_path']
      tempfile = Down.download("https://api.telegram.org/file/bot#{token}/#{file_path}")

      uploaded = upload(tempfile.path)
      id = uploaded['id']

      suggestion = suggestion(id)
      bot.api.send_message(chat_id: message.chat.id, text: suggestion)
    end
  end
end
