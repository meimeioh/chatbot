require 'telegram/bot'
require 'dotenv/load'
require 'httparty'

token = ENV["BOT_API_KEY"]

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::CallbackQuery
      # Here you can handle your callbacks from inline buttons
      if message.data == 'weather'
        kb = [Telegram::Bot::Types::KeyboardButton.new(text: 'Show me your location', request_location: true)]
        markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
        bot.api.send_message(chat_id: message.from.id, text: 'Where are you?', reply_markup: markup)
      end
    when Telegram::Bot::Types::Message
      kb = [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'What\'s the weather today?', callback_data: 'weather'),
      ]
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      bot.api.send_message(chat_id: message.chat.id, text: "How can I help you #{message.from.first_name}?", reply_markup: markup)
    end
  end
end
