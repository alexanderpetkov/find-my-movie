class Actor < ApplicationRecord
  include Searchable
  include Autocompletable

  enum gender: [:female, :male]

  autocomplete :name

  has_many :movies, through: :movie_starrings
  has_many :movie_starrings
end
