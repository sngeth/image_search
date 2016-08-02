class Api::ImagesearchController < ApplicationController
  def index
    search_term = params[:search]

    HTTParty.get('https://api.imgur.com/3/gallery/search?q='+search_term)

    render json: @results
  end
end
