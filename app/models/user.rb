class User < ApplicationRecord
  include Elasticsearch::Model
  index_name 'user'

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :character

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
      indexes :character, type: 'text', analyzer: 'kuromoji'
      indexes :description, type: 'text', analyzer: 'kuromoji'
    end
  end

  def as_indexed_json(*)
    attributes
      .symbolize_keys
      .slice(:id, :name, :sex, :account_id, :description)
      .merge(character: character_name)
  end

  def character_name
    character.name
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

  def search(query)
    elasticsearch__.search({
      query: {
        multi_match: {
          fields: %w(name sex account_id character_id description),
          type: 'cross_fields',
          query: query,
          operator: 'and'
        }
      }
    })
  end
end
