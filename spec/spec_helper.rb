require 'rubygems'
require 'bundler/setup'
require 'neo4j'

Neo4j::Session.open(:server_db)
