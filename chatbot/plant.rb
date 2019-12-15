require 'telegram/bot'
require 'dotenv/load'
require 'down'
require 'rest_client'
require 'base64'
require 'json'
require 'pry-byebug'


token = ENV['BOT_API_KEY']
plant = ENV['PLANT_API_KEY']

def upload(plant, file_path)
  base64_image =
    File.open(file_path, 'rb') do |file|
      Base64.strict_encode64(file.read)
    end

  params = {
    "key": plant,
    "images": [base64_image]
  }.to_json

  headers = {
    content_type: 'application/json'
  }

  RestClient.post 'https://api.plant.id/identify', params, headers
end

def suggestion(plant, upload_id)
  params = {
    "key": plant,
    "ids": [upload_id]
  }.to_json

  headers = {
    content_type: 'application/json'
  }

  RestClient.post 'https://api.plant.id/check_identifications', params, headers
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    unless message.document.nil?
      file_path = bot.api.getFile(file_id: message.document.file_id)['result']['file_path']
      tempfile = Down.download("https://api.telegram.org/file/bot#{token}/#{file_path}")

      base64_image =
        File.open(tempfile.path, 'rb') do |file|
          Base64.strict_encode64(file.read)
        end

      params1 = {
        "key": plant,
        "images": [base64_image]
      }.to_json

      headers = {
        content_type: 'application/json'
      }


      upload = JSON.parse((RestClient.post 'https://api.plant.id/identify', params1, headers))
      puts upload['id']

      sleep(10)

      params2 = {
        "key": plant,
        "ids": [upload['id']]
      }.to_json

      headers = {
        content_type: 'application/json'
      }

      binding.pry
      suggestion = RestClient.post 'https://api.plant.id/check_identifications', params2, headers

      puts suggestion
      bot.api.send_message(chat_id: message.chat.id, text: suggestion)
    end
  end
end

