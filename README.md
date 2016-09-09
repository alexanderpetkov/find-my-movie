# Find my Movie

This is a "Hello world" Rails + Elasticsearch project.

It is meant to serve as a starting point for anyone aiming to get a first hands-on experience with Rails and Elasticsearch. It will be expanded with more compelx functionality in the future.

# Installation

Start off with
`bundle install`

Use the `database.yml.example` to populate your database.yml. Make sure your PostgreSQL user has `login` and `createdb` permissions.

Then execute the usual:
`bundle exec rake db:create db:migrate`

[Install Elasticsearch 2.4](https://www.elastic.co/guide/en/elasticsearch/reference/current/_installation.html) and run it on port 9200.

Run `bundle exec rake elasticsearch:indices:create elasticsearch:import` to create indices for Movie, Actor, Director & Genre models and import any existing table entries you might have into their indices.

Run `bundle exec rake db:seed` to parse a dataset of ~1600 movies.

Run your server and visit localhost:3000 to check out the basic (elastic) serach.
