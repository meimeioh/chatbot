require 'telegram/bot'
require 'dotenv/load'
require 'httparty'

token = ENV["BOT_API_KEY"]

def getquote()
  url = 'https://quotes.rest/qod'
  response = HTTParty.get(url)
  response.parsed_response['contents']['quotes'][0]['quote']
end

def getjoke()
  url = 'https://api.jokes.one/jod'
  response = HTTParty.get(url)
  response.parsed_response['contents']['jokes'][0]['joke']['text']
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts message
    case message
    when Telegram::Bot::Types::CallbackQuery
      # Here you can handle your callbacks from inline buttons
      if message.data == 'quote'
        bot.api.send_message(chat_id: message.from.id, text: getquote())
      elsif message.data == 'joke'
        bot.api.send_message(chat_id: message.from.id, text: getjoke())
      end
    when Telegram::Bot::Types::Message
      kb = [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Inspire me!', callback_data: 'quote'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Joke of the day', callback_data: 'joke'),
      ]
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      bot.api.send_message(chat_id: message.chat.id, text: "How can I help you #{message.from.first_name}?", reply_markup: markup)
    end
  end
end


