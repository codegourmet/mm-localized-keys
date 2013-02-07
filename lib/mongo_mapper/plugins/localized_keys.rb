# encoding: utf-8

module MongoMapper
  module Plugins
    module LocalizedKeys

      extend ActiveSupport::Concern

      module ClassMethods

        def localized_keys(name, type, locales, options={})
          # create keys for each locale
          locales.each do |locale|
            key "#{name}_#{locale}", type, options
          end

          # create methods that take (optionally) locale as an argument
          # if no locale specified, use default locale
          class_eval do
            define_method(name) do |*args|
              locale = *args
              locale = I18n.locale unless locale.present?
              send("#{name}_#{locale}")
            end

            define_method("#{name}=") do |*args|
              value, locale = *args
              locale = I18n.locale unless locale.present?
              self["#{name}_#{locale}"] = value
            end
          end
        end

      end

    end
  end
end
