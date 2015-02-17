require 'rubygems'
require 'bundler/setup'
require 'neo4j'
require_relative 'lib/tweet_line'
require_relative 'lib/tweet_file'
require_relative 'lib/tweet_loader'
require_relative 'models/tweet'
require_relative 'models/user'

Neo4j::Session.open(:server_db)
