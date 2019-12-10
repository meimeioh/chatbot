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
    # print message
    case message.text
    when '/hello'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/bye'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    when '/quote'
      bot.api.send_message(chat_id: message.chat.id, text: getquote())
    when '/joke'
      bot.api.send_message(chat_id: message.chat.id, text: getjoke())
    when '/start'
    question = 'London is a capital of which country?'
    # See more: https://core.telegram.org/bots/api#replykeyboardmarkup
    answers =
      Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w(A B), %w(C D)], one_time_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}", reply_markup: answers)
    end
  end
end
