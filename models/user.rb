require 'neo4j'

class User
  include Neo4j::ActiveNode

  property :name

  has_many :out, :tweets, type: :WROTE
  has_many :in, :mentions, model_class: 'Tweet'
  has_many :both, :connected_with, model_class: 'User'

  def self.find_or_create(name)
    find_by(name: name) || create(name: name)
  end

  def was_mentioned_by(user)
    self.connected_with = first_order_connections_through_tweets
  end

  def first_order_connections_through_tweets
    query_as(:me).
      match("(me)-[:WROTE]->(:Tweet)-[:MENTIONS]->(other:User)-[:WROTE]->(:Tweet)-[:MENTIONS]->(me)").
      pluck(:other)
  end

  def nth_order_connections(n = 1)
    query_as(:me).
      match("(me)-[:CONNECTED_WITH*#{n}]-(other:User)").
      where("NOT (me = other OR (me)-[:CONNECTED_WITH*0..#{n-1}]-(other))").
      order('other.name').
      pluck('DISTINCT other')
  end
end
