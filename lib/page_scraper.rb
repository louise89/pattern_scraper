require 'nokogiri'
require 'httparty'

class PageScraper

  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get("https://store.closetcasepatterns.com/collections/sewing-patterns-all")
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def pattern_names
    parse_page.css(".product-list-item").css(".product-list-item-title").map(&:text)
  end

  def pattern_prices
    parse_page.css(".product-list-item").css(".product-list-item-price").css(".price").map do |price|
      price.text.strip
    end
  end
end
