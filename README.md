[![Circle CI](https://circleci.com/gh/RobinDaugherty/six-degrees.svg?style=shield&svg)](https://circleci.com/gh/RobinDaugherty/six-degrees)
[![Code Climate](https://codeclimate.com/github/RobinDaugherty/six-degrees/badges/gpa.svg)](https://codeclimate.com/github/RobinDaugherty/six-degrees)
[![Test Coverage](https://codeclimate.com/github/RobinDaugherty/six-degrees/badges/coverage.svg)](https://codeclimate.com/github/RobinDaugherty/six-degrees)

# six-degrees
Implementation of [Six Degrees](http://www.puzzlenode.com/puzzles/14-six-degrees-of-separation) using Neo4J.

## Ruby and Bundler
This project is written in Ruby and uses Bundler.
Prefix any commands with `bundle exec`.

Pry is also supported, including a `.pryrc` file so that everything is loaded up startup of Pry.

## Neo4J
Neo4J is assumed to be running on the standard port.

There are Rake tasks provided to install and control the Neo4J process, but I haven't gotten them working.
Success has been had with neo4j installed using Homebrew, and started thusly:

    brew install neo4j
    neo4j start

Using this method, you can use the [local Neo4J console](http://localhost::7474/) to inspect the dataset and try writing queries.

The project uses `Neo4J::ActiveNode` to implement an ActiveRecord-like pattern for the two model objects, and they
set up all relationships.

## Rake tasks
The functionality is exposed through Rake tasks.

    rake sixd:clear           # Clear out the database (get rid of data from previous runs)
    rake sixd:load            # Load complex_input.txt into the Neo4J database
    rake sixd:connections     # Print the connections for each User
