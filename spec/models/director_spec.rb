require 'rails_helper'

RSpec.describe Director, type: :model do
  it_behaves_like :autocompletable, :name
end
