"""
 The purpose of this code is to show how to work with plant.id API.
 You'll find API documentation at https://plantid.docs.apiary.io and https://plant.id/api
"""

import base64
import requests
from time import sleep

secret_access_key = ''

def send_for_identification(file_names):
  files_encoded = []
  for file_name in file_names:
    with open(file_name, 'rb') as file:
      files_encoded.append(base64.b64encode(file.read()).decode('ascii'))

  params = {
    'latitude': 49.194161,
    'longitude': 16.603017,
    'week': 23,
    'images': files_encoded,
    'key': secret_access_key,
    'parameters': ["crops_fast"]
  }
  # see the docs for more optinal atrributes; for example 'custom_id' allows you to work
  # with your own identifiers
  headers = {
    'Content-Type': 'application/json'
  }

  response = requests.post('https://plant.id/api/identify', json=params, headers=headers)

  if response.status_code != 200:
      raise("send_for_identification error: {}".format(response.text))

  # this reference allows you to gather the identification result (once its ready)
  return response.json().get('id')


def get_suggestions(request_id):
  params = {
      "key": secret_access_key,
      "ids": [request_id]
  }

  headers = {
      'Content-Type': 'application/json'
  }

  # To keep it simple, we are pooling the API waiting for the server to finish the identification.
  # The better way would be to utilise "callback_url" parameter in /identify call to tell the our server
  # to call your's server enpoint once the identificatin is done.
  while True:
    print("Waiting for suggestions...")
    sleep(5)
    resp = requests.post('https://plant.id/api/check_identifications', json=params, headers=headers).json()
    if resp[0]["suggestions"]:
      return resp[0]["suggestions"]

# more photos of the same plant increases the accuracy
request_id = send_for_identification(['./plant/plant.jpg'])

# just listing the suggested plant names here (without the certainty values)
for suggestion in get_suggestions(request_id):
  print(suggestion["plant"]["name"])
