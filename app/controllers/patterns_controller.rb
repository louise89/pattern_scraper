require 'closet_case'
require 'tilly_and_the_buttons'

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

    patterns_array.each do |name, price, designer, link, picture|
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

  def patterns_array
    closet_case_scraper.pattern_array + tilly_and_the_buttons_scraper.pattern_array
  end

  def closet_case_scraper
    @closet_case ||= ClosetCase.new
  end

  def tilly_and_the_buttons_scraper
    @tilly_and_the_buttons ||= TillyAndTheButtons.new
  end
end
