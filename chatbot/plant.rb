require 'telegram/bot'
require 'dotenv/load'
require 'down'

token = ENV['BOT_API_KEY']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts message
    unless message.document.nil?
      file_path = bot.api.getFile(file_id: message.document.file_id)['result']['file_path']
      Down.download("https://api.telegram.org/file/bot#{token}/#{file_path}", destination: "..")
    end
  end
end
