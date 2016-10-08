class Genre < ApplicationRecord
  include Searchable
  include Autocompletable

  autocomplete :name

  has_many :movies, through: :genre_belongings
  has_many :genre_belongings
end
