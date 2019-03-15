require 'nokogiri'
require 'httparty'

class ClosetCase

  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get("https://store.closetcasepatterns.com/collections/sewing-patterns-all")
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def patterns_array
    pattern_blocks = parse_page.css('div.product-list-item')

    pattern_blocks.map do |pattern_block|
      name = pattern_block.css("h3").text
      price = pattern_block.css(".product-list-item-price").text.strip
      link = pattern_block.css('.product-list-item-overlay-link').first['href']
      picture = pattern_block.css('.only-image').first['src']
      [name, price, 'Closet Case Patterns', link, picture]
    end
  end
end
