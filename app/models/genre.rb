class Genre < ApplicationRecord
  include Searchable
  include Autocompletable

  autocomplete :name

  settings index: { number_of_shards: 3 } do
    mappings dynamic: false do
      indexes :name, analyzer: 'english'
    end
  end

  def as_indexed_json(_opts = {})
    as_json.merge autocomplete_json
  end

  has_many :movies, through: :genre_belongings
  has_many :genre_belongings
end
