module Autocompletable
  extend ActiveSupport::Concern

  DEFAULT_SUGGESTIONS_COUNT = 20

  included do
    def autocomplete_json
      self.class.autocomplete_json(id)
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
          payload: { url: "/#{units}/#{id}" }
        }
      }
    end

    def suggest(text, size = nil)
      @completion = {
        field: "#{@field}_suggest",
        size: size || DEFAULT_SUGGESTIONS_COUNT
      }

      __elasticsearch__.client.suggest(query(text))
    end

    private

    def query(text)
      {
        index: index_name,
        body: {
          units.to_s => {
            text: text,
            completion: @completion
          }
        }
      }
    end

    def units
      to_s.downcase.pluralize
    end
  end
end
