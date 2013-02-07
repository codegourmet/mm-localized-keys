# encoding: UTF-8

require 'test_helper'

class PublishingLogicTest < ActiveSupport::TestCase

  setup do
    Page.delete_all
  end


  test "should define keys" do
    [:title, :title_de, :title_en].each do |key|
      assert Page.keys.keys.include?(key.to_s), "should define key #{key}"
    end
  end


  test "should pass mongo_mapper options correctly" do
    flunk Page.new.save, "shouldn't save without required attribute"
    flunk Page.new(title_de: 'de').save, "options should be passed to all locale attributes"
    assert Page.new(title_de: 'de', title_en: 'en').save, "options should be passed to all locale attributes"
  end


  test "localized accessors" do
    page = Page.create(title_de: 'de', title_en: 'en')

    I18n.locale = :de
    assert_equal 'de', page.title, "should infer the current locale"

    page.title = 'de_2'
    assert_equal 'de_2', page.title, "write accessor should work"

    page.title = 'de'
    page.save
    page.title = 'de_2'
    page.reload
    assert_equal 'de', page.title, "should persist correctly"

    assert_equal 'en', page.title(:en), "locale param read accessor should work as expected"

    page.send(:title=, :en, 'en_2')
    assert_equal 'en', page.title_en, "locale param write accessor should work as expected"
  end

end
