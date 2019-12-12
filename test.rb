require 'telegram/bot'
require 'dotenv/load'
require 'down'
require 'rest_client'
require 'base64'

token = ENV['BOT_API_KEY']
plant = ENV['PLANT_API_KEY']

# Telegram::Bot::Client.run(token) do |bot|
#   bot.listen do |message|
#     puts message
#     unless message.document.nil?
#       file_path = bot.api.getFile(file_id: message.document.file_id)['result']['file_path']
#       tempfile = Down.download("https://api.telegram.org/file/bot#{token}/#{file_path}")
#       params = {
#         "key": plant, # required - string
#         "images": [tempfile.path]
#       }

#       headers = {
#         :content_type => 'application/json'
#       }

#       response = RestClient.post 'https://api.plant.id/identify', params, headers
#       puts response
#     end
#   end
# end

 # 698616

# file_path = './plant/plant1.jpg'

# base64_image =
#   File.open(file_path, 'rb') do |file|
#     Base64.strict_encode64(file.read)
#   end

# puts base64_image

# identify_params = {
#   'key': plant, # required - string
#   'image': [base64_image]
# }.to_json

# headers = {
#   content_type: 'application/json'
# }

# response = RestClient.post 'https://api.plant.id/identify', identify_params, headers
# puts response

# def upload(plant, file_path)
#   base64_image =
#     File.open(file_path, 'rb') do |file|
#       Base64.strict_encode64(file.read)
#     end

#   identify_params = {
#     'key': plant, # required - string
#     'image': [base64_image]
#   }.to_json

#   headers = {
#     content_type: 'application/json'
#   }

#   response = RestClient.post 'https://api.plant.id/identify', identify_params, headers
#   puts response
# end

# upload = upload(plant, './plant/plant1.jpg')
# puts upload


# def suggestions(plant, upload)
#   check_params = {
#     'key': plant,
#     'ids': [upload['id']]
#   }

#   headers = {
#     content_type: 'application/json'
#   }

#   while True
#     print('Waiting for suggestions...')
#     sleep(5)
#     resp = RestClient.post 'https://api.plant.id/check_identifications', check_params, headers
#     if resp[0]['suggestions']
#       resp[0]['suggestions']
#     end
#   end
# end


# suggestion = suggestions(plant, upload)
# puts suggestion
# puts suggestion["plant"]["name"]

quote = {"id": 698866, "custom_id": null, "custom_url": null, "callback_url": null, "latitude": null, "longitude": null, "week": null, "created": 1576145912.506012, "sent": null, "classified": null, "images": [{"file_name": "71cd32da8b7f42e68d750170aa93c59e.jpg", "url": "https://plant.id/media/images/71cd32da8b7f42e68d750170aa93c59e.jpg", "url_small": "https://plant.id/media/images/71cd32da8b7f42e68d750170aa93c59e_small.jpg", "url_tiny": "https://plant.id/media/images/71cd32da8b7f42e68d750170aa93c59e_tiny.jpg"}], "suggestions": [], "parameters": [], "feedback": null, "secret": "yM30tW1375IHlGK", "fail_cause": null, "countable": true, "source": "ohmeixuan@hotmail.com"}

