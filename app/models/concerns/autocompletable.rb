module Autocompletable
  extend ActiveSupport::Concern

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
      {
        "#{@field}_suggest" => {
          input:  @field,
          output: @field,
          payload: { url: "/movies/#{id}" }
        }
      }
    end
  end
end
