class Genre < ApplicationRecord
  include Searchable

  has_and_belongs_to_many :movies
end
