require 'rails_helper'

RSpec.describe Movie, type: :model do
  it_behaves_like :autocompletable, :title
end
