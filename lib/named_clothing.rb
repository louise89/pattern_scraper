require 'nokogiri'
require 'httparty'

class NamedClothing

  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get("https://www.namedclothing.com/product-category/all-patterns/")
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def patterns_array
    pattern_blocks = parse_page.css('div.product type-product')

    pattern_blocks.map do |pattern_block|
      name = pattern_block.css('li.product h2').text
      price = pattern_block.css('li.product span').text
      link = pattern_block.css('.product').map{ |link| link['href'] }
      picture = pattern_block.css('.only-image').first['src']
      [name, price, 'Closet Case Patterns', link, picture]
    end
  end
end
