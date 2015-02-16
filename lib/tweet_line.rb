class TweetLine
  attr_accessor :unparsed

  def initialize(unparsed)
    self.unparsed = unparsed
  end

  def user
    matches[:user]
  end

  def message
    matches[:message]
  end

  def mentions
    message.scan(/@([a-z0-9_]+)/i).map { |m| m[0] }
  end

  private

  def matches
    @matches = unparsed.match /\A(?<user>[a-z0-9_]+): (?<message>.+)\Z/i
  end
end
