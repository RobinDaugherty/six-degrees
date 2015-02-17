require 'neo4j'

class Tweet
  include Neo4j::ActiveNode

  property :message

  has_many :out, :mentions, model_class: 'User', after: :mentioned_user
  has_one :in, :user, type: :WROTE

  def mentioned_user(mentioned_user)
    mentioned_user.was_mentioned_by(user)
  end
end
