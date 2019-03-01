require "page_scraper"

class PatternsController < ApplicationController

  def index
    @pattern = Pattern.all
  end

  def new
  end

  def show
  end

  def create
    # extract {designer/name/price/link/picture}
    # loop over data
    #   with data find an existing entry in the db or create a new one based on designer/name as FK.
    #   update the record found with scraped data
    # end

    pattern_array.each do |name, price, designer, link, picture|
      Pattern.create(
        name: name,
        price: price,
        designer: designer,
        link: link,
        picture: picture
      )
    end
      flash[:notice] = 'Scrape Completed!'
      redirect_to patterns_path
  end

  private

  def pattern_array
    pattern_name.zip(pattern_price, pattern_designer, pattern_link, pattern_picture)
  end

  def pattern_name
    @names ||= PageScraper.new.pattern_names
  end

  def pattern_price
    @prices ||= PageScraper.new.pattern_prices
  end

  def pattern_designer
    @designers ||= PageScraper.new.pattern_designers
  end

  def pattern_link
    @links ||= PageScraper.new.pattern_links
  end

  def pattern_picture
    @pictures ||= PageScraper.new.pattern_pictures
  end
end
