require 'nokogiri'
require 'httparty'

class TillyAndTheButtons

  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get("https://shop.tillyandthebuttons.com/collections/sewingpatterns")
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def pattern_array
    pattern_names.zip(pattern_prices, pattern_designers, pattern_links, pattern_pictures)
  end

  def pattern_designers
    parse_page.css(".site-header__logo a img").map{|link| link['alt']}
  end

  def pattern_links
    parse_page.css(".grid__item .grid-link").map{|link| link['href']}
  end

  def pattern_pictures
    parse_page.css('div.grid__item a span img').map { |image| image['src']}
  end

  def pattern_names
    parse_page.css('div.grid__item p.grid-link__title:first-of-type').map(&:text)
  end

  def pattern_prices
    parse_page.css(".grid-link__meta > span.money").map do |element|
      element.text.gsub('&pound', '£')
    end
  end
end
