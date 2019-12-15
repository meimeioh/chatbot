require 'telegram/bot'
require 'dotenv/load'
require 'httparty'

token = ENV["BOT_API_KEY"]

def get_weather(lat, long)
  weather = ENV["WEATHER_API_KEY"]
  url = "https://api.darksky.net/forecast/#{weather}"
  update_location = "#{url}/#{lat},#{long}"
  response = HTTParty.get(update_location)
  "Right now: #{response['currently']['summary']}
Today: #{response['hourly']['summary']}
This week: #{response['daily']['summary']}"
end

# puts get_weather(1.3521, 103.8198)

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::CallbackQuery
      # Here you can handle your callbacks from inline buttons
      if message.data == 'weather'
        kb = [Telegram::Bot::Types::KeyboardButton.new(text: 'Send your location!', request_location: true)]
        markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb, resize_keyboard: true, one_time_keyboard: true)
        bot.api.send_message(chat_id: message.from.id, text: 'Where are you?', reply_markup: markup)
      end
    when Telegram::Bot::Types::Message
      # puts "From #{message.from.id}"
      # puts "Chats #{message.chat.id}"
      # puts message.location == nil
      if !message.location.nil?
        lat = message.location.latitude
        long = message.location.longitude
        bot.api.send_message(chat_id: message.chat.id, text: get_weather(lat, long))
      else
        kb = [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'What\'s the weather today?', callback_data: 'weather'),
        ]
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
        bot.api.send_message(chat_id: message.chat.id, text: "How can I help you #{message.from.first_name}?", reply_markup: markup)
      end
    end
  end
end
