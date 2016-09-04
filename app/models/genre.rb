class Genre < ApplicationRecord
  include Searchable

  has_many :movies, through: :genre_belongings
  has_many :genre_belongings
end
