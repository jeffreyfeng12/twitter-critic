#! /usr/bin/env ruby
require 'twitter'
require 'rest-client'

# Twitter creds
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "GulvEZbQ2JECw92VX59R4Uwdp"
  config.consumer_secret     = "Usg8SjNB4DTgutqaryNIrCbcol3fecn4yXTGDWWxOnQytZvcHZ"
  config.access_token        = "4136434629-RuoxvsUPctBBg7heG3dAS2iexRcukPbOL65Xiwk"
  config.access_token_secret = "XOYm7OHf1Z85b2qTYdhGOZhvb5Ac4QepZ7uswvThhz5Ps"
end

def collect_with_max_id(collection=[], max_id=nil, &block)
  response = yield(max_id)
  collection += response
  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
end

def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    options = {count: 50, include_rts: true}
    options[:max_id] = max_id unless max_id.nil?
    user_timeline(user, options)
  end
end

arr = client.get_all_tweets("RealDonaldTrump")
text = []
arr.each do |tweet| 
  text.push(tweet.full_text)
end

File.open('dataFile.txt', 'w') { |file| file.write(text.join("$*$*$")) }

exec("python vader.py")