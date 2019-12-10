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
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    when '/quote'
      bot.api.send_message(chat_id: message.chat.id, text: getquote())
    when '/joke'
      bot.api.send_message(chat_id: message.chat.id, text: getjoke())
    end
  end
end


