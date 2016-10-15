require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe '#movies' do
    context 'parsing query' do
      it 'requires :q parameter' do
        q_missing = -> { get_xhr :movies }

        expect(q_missing).to raise_error ActionController::ParameterMissing
      end

      it 'parses only letters, digits & spaces' do
        get_xhr :movies, q: 'the @Godfather 2!!'

        expect(assigns(:query)).to eq 'the Godfather 2'
      end
    end
  end
end
