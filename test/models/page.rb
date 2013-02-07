require "mongo_mapper"
require "mm-localized-keys"

class Page
  include MongoMapper::Document
  include MongoMapper::Plugins::LocalizedKeys

  localized_keys :title, [:de, :en], String, required: true
end
