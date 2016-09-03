class Actor < ApplicationRecord
  enum gender: [:female, :male]

  has_and_belongs_to_many :movies
end