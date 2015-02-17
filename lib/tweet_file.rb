require_relative 'tweet_line'

class TweetFile
  attr_accessor :filename

  def initialize(filename)
    self.filename = filename
  end

  def tweet_lines
    each_line.map { |l| TweetLine.new(l) }
  end

  private

  def each_line
    file_contents.each_line.lazy
  end

  def file
    @file ||= File.open filename
  end

  def file_contents
    @file_contents ||= file.read
  end
end
