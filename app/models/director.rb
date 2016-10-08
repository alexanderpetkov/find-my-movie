class Director < ApplicationRecord
  include Searchable
  include Autocompletable

  autocomplete :name

  has_many :movies
end
