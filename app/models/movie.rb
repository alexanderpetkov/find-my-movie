require 'elasticsearch/model'

class Movie < ApplicationRecord
  include Searchable

  belongs_to :director, optional: true

  has_many :actors, through: :movie_starrings
  has_many :movie_starrings

  has_many :genres, through: :genre_belongings
  has_many :genre_belongings
end
