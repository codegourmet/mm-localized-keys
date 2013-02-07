# encoding: UTF-8

require 'test_helper'

class PublishingLogicTest < ActiveSupport::TestCase

  setup do
    Page.delete_all
  end


  test "should define keys and accessors" do
    [:title_de, :title_en].each do |key|
      assert Page.keys.keys.include?(key.to_s), "should define key #{key}"
    end

    [:title, :title=].each do |method|
      assert Page.new.respond_to?(method), "should define method #{method}"
    end
  end


  test "should check locales param type" do
    assert_raises(ArgumentError) do
      Page2 = Class.new(Page) do
        localized_keys :faulty, String, 'de'
      end
    end
  end


  test "should pass mongo_mapper options correctly" do
    assert !Page.new.save, "shouldn't save without required attribute"
    assert !Page.new(title_de: 'de').save, "options should be passed to all locale attributes"
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

    page.send(:title=, 'en_2', :en)
    assert_equal 'en_2', page.title_en, "locale param write accessor should work as expected"
  end


  test "shouldn't allow invalid locales as accessor params" do
    page = Page.create(title_de: 'de', title_en: 'en')

    assert_raises(NoMethodError) { page.title(:unknown_locale) }
    assert_raises(NoMethodError) { page.send(:title=, 'test', :unknown_locale) }
  end

end
