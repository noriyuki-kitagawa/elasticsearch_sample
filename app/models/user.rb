class User < ApplicationRecord
  include Elasticsearch::Model
  index_name "user"

  enum sex: {
    man: 1,
    woman: 2,
    neither: 3,
  }

  settings do
    mappings dynamic: 'false' do
      indexes :id, type: 'integer'
      indexes :name, type: 'text', analyzer: 'kuromoji'
      indexes :sex, type: 'keyword'
      indexes :account_id, type: 'keyword'
    end
  end

  def self.create_index!
    client = __elasticsearch__.client
    client.indices.delete index: self.index_name rescue nil
    client.indices.create(index: self.index_name,
      body: {
        settings: self.settings.to_hash,
        mappings: self.mappings.to_hash
      })
  end
end
