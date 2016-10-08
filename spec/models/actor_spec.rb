require 'rails_helper'

RSpec.describe Actor, type: :model do
  it_behaves_like :autocompletable, :name
end
