require_relative 'tweet_file'
require_relative '../models/tweet'
require_relative '../models/user'

class TweetLoader
  attr_accessor :filename

  def initialize(filename)
    self.filename = filename
  end

  def load
    tweets.each do |tweet|
      tweet.save!
    end
  end

  def create_tweets
    tweet_lines.map do |tweet_line|
      create_tweet_for_tweet_line(tweet_line)
    end
  end

  private

  def create_tweet_for_tweet_line(tweet_line)
    Tweet.create(
      message: tweet_line.message,
      user: User.find_or_create(tweet_line.user),
      mentions: tweet_line.mentions.map { |m| User.find_or_create(m) },
    )
  end

  def tweet_lines
    tweet_file.tweet_lines
  end

  def tweet_file
    @file ||= TweetFile.new(filename)
  end
end
