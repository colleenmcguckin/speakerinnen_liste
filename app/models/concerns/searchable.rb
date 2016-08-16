module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { number_of_shards: 1 } do
      def as_indexed_json(options={})
        self.as_json({
          only: [:firstname, :lastname, :email],
          include: {
            methods: [:fullname],
            medialinks: { only: [:title, :url] }
            }
        })
      end

      # create index
      Profile.__elasticsearch__.create_index! force: true
      Profile.__elasticsearch__.import


      def self.search(query)
        options[:per_page] ||= 10
        options[:from] = options[:page] * options[:per_page]

        Profile.__elasticsearch__.search(
          query: { query_string: {
            query: "*text search terms* AND type:\"profile\" AND published:\"true\""
          }},
          size: options[:per_page],
          from: options[:from]
        )
      end
    end
  end
end
