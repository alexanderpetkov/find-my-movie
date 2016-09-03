class Actor < ApplicationRecord
  enum gender: [:female, :male]
end