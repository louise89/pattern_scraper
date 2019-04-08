require 'nokogiri'
require 'httparty'

class TillyAndTheButtons

  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get("https://shop.tillyandthebuttons.com/collections/sewingpatterns")
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def patterns_array
    pattern_blocks = parse_page.css('div.grid__item')

    pattern_blocks.map do |pattern_block|
      name = pattern_block.css('p.grid-link__title:first-of-type').text
      price = pattern_block.css(".grid-link__meta > span.money").map do |element|
        element.text.gsub('&pound', '£')
      end
      link = pattern_block.css('.grid-link').map{ |link| link['href'] }
      picture = pattern_block.css('a span img').map { |image| image['src']}
      [name, price, 'Tilly and the Buttons', link, picture]
    end
  end
end
