require 'httparty'

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
