class Movie < ApplicationRecord
  include Searchable

  belongs_to :director, optional: true

  has_many :actors, through: :movie_starrings
  has_many :movie_starrings

  has_many :genres, through: :genre_belongings
  has_many :genre_belongings

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english', index_options: 'offsets'
    end
  end

  def as_indexed_json(options={})
    self.as_json(
      include: { genres: { only: :name},
                 actors:    { only: :name },
                 director:   { only: :name }
               })
  end
end
