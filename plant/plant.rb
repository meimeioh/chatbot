require 'open-uri'

content = open('http://google.com').read
puts content
