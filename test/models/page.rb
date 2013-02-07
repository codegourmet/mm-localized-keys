require "mongo_mapper"
require "mm-localized-keys"

class Page
  include MongoMapper::Document
  include MongoMapper::Plugins::LocalizedKeys

  localized_keys :title, String, [:de, :en], required: true
end
