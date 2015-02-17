require_relative 'startup'
require_relative 'lib/tweet_loader'
require 'pry'
require 'neo4j'

load 'neo4j/tasks/neo4j_server.rake'
load 'neo4j/tasks/migration.rake'

namespace :sixd do
  desc "Clear out the database. Destroy everything."
  task clear: [] do
    Neo4j::Session.query <<-Cypher
      MATCH (n)
      OPTIONAL MATCH (n)-[r]-()
      DELETE n,r
    Cypher
  end

  desc "Loads complex_input.txt into the Neo4J database"
  task load: [] do
    tl = TweetLoader.new(File.expand_path('../complex_input.txt', __FILE__))
    # tl = TweetLoader.new(File.expand_path('../spec/fixtures/sample_input.txt', __FILE__))
    tweets = tl.create_tweets
    puts "Imported #{tweets.count} tweets."
  end

  def print_connection(user, connection)
    puts "#{user.name} <--> #{connection.name}"
  end

  desc "Prints the connections for each user"
  task connections: [] do
    User.all.each do |user|
      first = user.nth_order_connections(1)
      second = user.nth_order_connections(2)
      third = user.nth_order_connections(3)

      if (first + second + third).count > 0
        puts user.name
        puts first.map(&:name).join(', ') if first.count > 0
        puts second.map(&:name).join(', ') if second.count > 0
        puts third.map(&:name).join(', ') if third.count > 0
        puts
      end
    end
  end
end
