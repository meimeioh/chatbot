import requests

response = requests.get('https://quotes.rest/qod')

print(response.json()['contents']['quotes'][0]['quote'])
