require 'down'
require 'rest_client'
require 'base64'
require 'json'
require 'pry-byebug'

def upload(file_path)
  plant = ENV['PLANT_API_KEY']
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


  result = RestClient.post 'https://api.plant.id/identify', params, headers
  JSON.parse(result) # get upload_id
end

def suggestion(upload_id)
  plant = ENV['PLANT_API_KEY']

  params = {
    "key": plant,
    "ids": [upload_id]
  }.to_json

  headers = {
    content_type: 'application/json'
  }

  puts 'Waiting for suggestions'

  sleep(5)

  result = RestClient.post 'https://api.plant.id/check_identifications', params, headers
  suggestion = JSON.parse(result)
  top_plant = suggestion[0]['suggestions'][0]
  "This plant is most likely #{top_plant['plant']['name']}! Find out more here: #{top_plant['plant']['url']
}"
end
