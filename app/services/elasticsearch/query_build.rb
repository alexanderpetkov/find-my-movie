require 'elasticsearch/dsl'

module Elasticsearch
  class QueryBuilder
    class << self

      def matchle(on:, text:)
        query do
          byebug

          match on => text
        end
      end

      def phrase(text)
        query do
          match :title do
            query text
            type :phrase
          end
        end
      end

      def phrase_prefix
      end

      private

      def query
        Elasticsearch::DSL::Search.search do
          query do
            yield
          end
        end
      end
    end
  end
end
