require 'nokogiri'
require 'httparty'

class PageScraper

  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get("https://store.closetcasepatterns.com/collections/sewing-patterns-all")
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def pattern_designers
    parse_page.css('div.branding a img').map { |title| title['alt']}
  end

  def pattern_links
    parse_page.css('div.product-list-item a').map { |link| link['href'] }
  end

  def pattern_pictures
    parse_page.css('div.product-list-item figure a img').map { |image| image['src']}
  end

  def pattern_names
    parse_page.css("div.product-list-item h3").map{ |title| title.text}
  end

  def pattern_prices
    parse_page.css("div.product-list-item p").map{ |price| price.text.strip}
  end
end
