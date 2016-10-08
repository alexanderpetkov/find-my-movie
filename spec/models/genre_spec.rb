require 'rails_helper'

RSpec.describe Genre, type: :model do
  it_behaves_like :autocompletable, :name
end
