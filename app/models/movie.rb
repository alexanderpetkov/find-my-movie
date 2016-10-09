class Movie < ApplicationRecord
  include Searchable
  include Autocompletable

  belongs_to :director, optional: true

  has_many :actors, through: :movie_starrings
  has_many :movie_starrings

  has_many :genres, through: :genre_belongings
  has_many :genre_belongings

  autocomplete :title

  settings index: { number_of_shards: 3 } do
    mappings dynamic: false do
      indexes :title, analyzer: 'english', index_options: 'offsets'
    end
  end

  def as_indexed_json(_opts = {})
    as_json(
      include: {
        genres:   { only: :name },
        actors:   { only: :name },
        director: { only: :name }
      }
    ).merge autocomplete_json
  end
end
