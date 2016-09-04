class Actor < ApplicationRecord
  include Searchable

  enum gender: [:female, :male]

  has_many :movies, through: :movie_starrings
  has_many :movie_starrings
end
