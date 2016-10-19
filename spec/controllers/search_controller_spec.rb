require 'rails_helper'

RSpec.describe SearchController, elasticsearch: true, type: :controller do
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

    context 'setting variables' do
      let(:search_result) { double(records: movies_found) }

      before(:each) do
        allow(Movie).to receive(:search).and_return(search_result)

        get_xhr :movies, q: 'sth'
      end

      context '@movie' do
        let(:movies_found) { create_n_movies(5) }

        it 'assigns result records in @movie' do
          expect(assigns(:movies)).to eq movies_found
        end
      end

      context '@more_left' do
        context 'with < 10 results' do
          let(:movies_found) { create_n_movies(9) }

          it { expect(assigns(:more_left)).to be_falsey }
        end

        context 'with 10 results' do
          let(:movies_found) { create_n_movies(10) }

          it { expect(assigns(:more_left)).to be_falsey }
        end

        context 'with > 10 results' do
          let(:movies_found) { create_n_movies(11) }

          it { expect(assigns(:more_left)).to be_truthy }
        end
      end

      private

      def create_n_movies(n)
        1.upto(n).map { create(:movie) }
      end
    end
  end

  describe '#movie_suggestions' do
    let(:suggestions) { %w(one two three) }
    let(:sample_result) do
      {
        'movies' => [{ 'options' => suggestions }]
      }
    end

    before(:each) do
      allow(Movie).to receive(:suggest).and_return(sample_result)

      get_xhr :movie_suggestions, q: 'sth'
    end

    context 'setting variables' do
      context '@suggestions' do
        it 'assigns suggestions to @suggestions' do
          expect(assigns(:suggestions)).to eq suggestions
        end
      end
    end
  end
end
