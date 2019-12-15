def get_weather(lat, long)
  weather = ENV["WEATHER_API_KEY"]
  url = "https://api.darksky.net/forecast/#{weather}"
  update_location = "#{url}/#{lat},#{long}"
  response = HTTParty.get(update_location)
  "Right now: #{response['currently']['summary']}
Today: #{response['hourly']['summary']}
This week: #{response['daily']['summary']}"
end
