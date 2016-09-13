module Autocompletable
  extend ActiveSupport::Concern

  class_methods do
    def autocomplete(field)
      mappings do
        indexes "#{field}_suggest", type: 'completion', payloads: true
      end
    end
  end
end
