class Actor < ApplicationRecord
  include Searchable

  enum gender: [:female, :male]

  has_and_belongs_to_many :movies
end