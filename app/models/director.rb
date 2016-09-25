class Director < ApplicationRecord
  include Searchable
  include Autocompletable

  has_many :movies
end
