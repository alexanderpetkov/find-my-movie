class Director < ApplicationRecord
  include Searchable

  has_many :movies
end