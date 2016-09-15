module Autocompletable
  extend ActiveSupport::Concern

  DEFAULT_SUGGESTIONS_COUNT = 20

  included do
    def autocomplete_json
      self.class.autocomplete_json(self.id)
    end
  end

  class_methods do
    def autocomplete(field)
      @field = field

      mappings do
        indexes "#{field}_suggest", type: 'completion', payloads: true
      end
    end

    def autocomplete_json(id)
      suggested = find(id).send(@field)

      {
        "#{@field}_suggest" => {
          input: suggested,
          output: suggested,
          payload: { url: "/movies/#{id}" }
        }
      }
    end

    def suggest(text, size = nil)
      units = self.to_s.downcase.pluralize
      completion = {
        field: "#{@field}_suggest",
        size: size || DEFAULT_SUGGESTIONS_COUNT
      }

      query = {
        index: self.index_name,
        body: {
          "#{units}" => {
            text: text,
            completion: completion
          }
        }
      }

      self.__elasticsearch__.client.suggest(query)
    end
  end
end
