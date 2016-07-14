module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    # include Elasticsearch::Model::Callbacks

    # settings index: { number_of_shards: 1 } do
    #   mappings dynamic: 'false' do
    #     indexes :firstname, type: 'string'
    #     indexes :email, type: 'string'
    #   end
    # end

    def as_indexed_json(options={})
     self.as_json(
      include: {
                  medialinks: { only: [:title, :url] }
               })
    end

    def self.search(query)
      # ...
    end
  end
end
