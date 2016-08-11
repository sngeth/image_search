class Api::ImagesearchController < ApplicationController
  def index
    query = {"q" => params[:search]}

    imgur_client_id = Rails.application.secrets[:IMGUR_CLIENT_ID]
    headers = {
      "Authorization" => imgur_client_id
    }

    @results = HTTParty.get("https://api.imgur.com/3/gallery/search",
                 query: query, headers: headers )

    render json: @results.as_json
  end
end
