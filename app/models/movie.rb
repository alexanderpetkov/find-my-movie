require 'elasticsearch/model'

class Movie < ApplicationRecord
  include Searchable

  belongs_to :director, optional: true

  has_and_belongs_to_many :actors
  has_and_belongs_to_many :genres
end