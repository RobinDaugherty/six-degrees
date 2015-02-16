require 'neo4j'

class User
  include Neo4j::ActiveNode

  property :name

  has_many :in, :tweets, type: :wrote
  has_many :in, :mentions, type: :mentions, class_name: 'Tweet'

  def self.find_or_create(name)
    find_by(name: name) || create(name: name)
  end
end
