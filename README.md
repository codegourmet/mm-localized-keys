# mm-localized-keys

Localized keys for Rails/MongoMapper models.

This is just a gemification + tests.

The original code is from Thomas Celizna:
https://github.com/tomasc

## Installation

Add this line to your application's Gemfile:

    gem 'mm-localized-keys'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mm-localized-keys

## Usage

Just include it in your models. It handles exaktly like mongo_mapper `keys`, but with an additional locales parameter.

    class Page
      include MongoMapper::Document
      plugin MongoMapper::Plugins::LocalizedKeys

      localized_keys :title, I18n.available_locales, String, required: true
    end

This will add some r/w accessors and keys, depending on the locales parameter passed.

### Example
    This plugin will add a localized attribute for every locale. Also, it will add a non-localized r/w accessor which will route to the aforementioned keys depending on which locale is currently set (or supplied via param, see below).

    NOTE: all options that you append to the `localized_keys` call will be passed through to the mongo_mapper `key` method.

    class Page
      include MongoMapper::Document
      plugin MongoMapper::Plugins::LocalizedKeys

      localized_keys :title, [:de, :en], String
    end

    page = Page.new

    I18n.locale = :de
    page.title = 'test [de]'
    puts page.title # => 'test [de]'

    page.title_en = 'test [en]'
    I18n.locale = :en
    puts page.title # => 'test [en]'

    puts page.title(:de) # => 'test [de]'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
