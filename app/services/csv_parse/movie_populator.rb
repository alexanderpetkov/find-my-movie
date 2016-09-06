require 'csv'

module CSVParse
  class MoviePopulator
    MOVIES_PATH = 'datasets/movies.csv'
    CSV_OPTS = { encoding: 'iso-8859-1:utf-8', col_sep: ';' }

    def parse
      CSV.foreach(MOVIES_PATH, CSV_OPTS) do |row|
        next if $INPUT_LINE_NUMBER < 3
        puts "Parsing row ##{$INPUT_LINE_NUMBER}"

        @row = row


        movie = Movie.find_or_create_by(title: title, year: year)
        movie.update(length: length, director: director, award_winning: award?)

        movie.actors << actors
        movie.genres << genre
      end
    end

    private

    def title
      parse_name(@row[2])
    end

    def genre
      Genre.find_or_create_by(name: @row[3].to_s.capitalize)
    end

    def year
      @row[0].to_i
    end

    def director
      director = Director.find_or_create_by(name: parse_name(@row[6]))
    end

    def length
      @row[1].to_i
    end

    def award?
      @row[9].to_s.downcase == 'yes'
    end

    def actor_name
      parse_name(@row[4])
    end

    def actress_name
      parse_name(@row[5])
    end

    def actors
      actor = Actor.find_or_create_by(name: actor_name, gender: :male)
      actress = Actor.find_or_create_by(name: actress_name, gender: :female)

      [actor, actress]
    end

    def parse_name(name)
      return if name.blank?

      name.split(',').reverse.join(' ')
    end
  end
end
