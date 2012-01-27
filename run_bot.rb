# encoding: UTF-8
$stdout.sync = true
require_relative 'twitter_auth.rb'
require_relative 'statistics_bot'
require 'tweetbot'

bot = TweetBot.configure do |config|
  config.twitter_auth = TwitterAuth::AuthKeys
  config.response_frequency = 1

  RESPONSES = [ -> { "You know, #{StatisticsBot.stat}% of statistics are make up on the spot!" } ].map do |response|
    def response.to_s
      call
    end
    response
  end

  config.respond_to_phrase 'percent' do |resp| resp.concat RESPONSES end
  config.respond_to_phrase 'percentage' do |resp| resp.concat RESPONSES end

end

bot.talk
