require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  before(:each) { stub_elasticsearch }

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

    context 'parsing offset' do
      it 'defaults to 0 when not passed' do
        get_xhr :movies, q: 'sth'

        expect(assigns(:offset)).to be_zero
      end

      it 'is stored as fixnum' do
        get_xhr :movies, q: 'sth', offset: 10

        expect(assigns(:offset)).to be_kind_of Integer
      end
    end

    context 'passing search params' do
      it 'passes query to search' do
        expect_args('sth', anything)

        get_xhr :movies, q: 'sth', offset: 20
      end

      it 'wants 10 results' do
        expect_args(anything, hash_including(size: 10))

        get_xhr :movies, q: 'sth', offset: 20
      end

      it 'passes offset' do
        expect_args(anything, hash_including(from: 20))

        get_xhr :movies, q: 'sth', offset: 20
      end

      private

      def expect_args(*expected)
        expect(Movie).to receive(:search)
          .with(*expected)
          .and_return(double(records: {}))
      end
    end

    context '@movie' do
      it 'assigns result records in @movie' do
        allow(Movie).to receive(:search).and_return(double(records: []))

        get_xhr :movies, q: 'sth'

        expect(assigns(@movies)).to eq []
      end
    end
  end
end
