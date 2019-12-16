# gems for telegram bot
require 'telegram/bot'
require 'dotenv/load'

# methods from other files
require_relative 'trivia'
require_relative 'weather'
token = ENV['MORCHOO_API_KEY']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::CallbackQuery
      # Here you can handle your callbacks from inline buttons
      if message.data == 'quote'
        bot.api.send_message(chat_id: message.from.id, text: getquote)
      elsif message.data == 'joke'
        bot.api.send_message(chat_id: message.from.id, text: getjoke)
      elsif message.data == 'weather'
        kb = [Telegram::Bot::Types::KeyboardButton.new(text: 'Send your location!', request_location: true)]
        markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb, resize_keyboard: true, one_time_keyboard: true)
        bot.api.send_message(chat_id: message.from.id, text: 'Where are you?', reply_markup: markup)
      end
    when Telegram::Bot::Types::Message
      if !message.location.nil?
        lat = message.location.latitude
        long = message.location.longitude
        bot.api.send_message(chat_id: message.chat.id, text: get_weather(lat, long))
      elsif
        kb = [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Inspire me!', callback_data: 'quote'),
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Joke of the day', callback_data: 'joke'),
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'What\'s the weather like?', callback_data: 'weather')
        ]
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
        bot.api.send_message(chat_id: message.chat.id, text: "How can I help you today #{message.from.first_name}?", reply_markup: markup)
      end
    end
  end
end
