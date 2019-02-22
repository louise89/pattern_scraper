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
    pattern_array.each do |name, price|
      Pattern.create(name: name, price: price)
    end

    if @pattern.save
      flash[:notice] = 'Scrape Completed!'
      redirect_to patterns_path
    else
      flash[:alert] = 'Scrape not completed'
    end
  end

  private

  def pattern_array
    pattern_name.zip(pattern_price)
  end

  def pattern_name
    @names ||= PageScraper.new.pattern_names
  end

  def pattern_price
    @prices ||= PageScraper.new.pattern_prices
  end
end
