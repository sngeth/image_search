class Api::ImagesearchController < ApplicationController
  def index
    query = {"q" => params[:search]}

    imgur_client_id = Rails.application.secrets[:IMGUR_CLIENT_ID]
    headers = {
      "Authorization" => imgur_client_id
    }

    @results = HTTParty.get("https://api.imgur.com/3/gallery/search",
                 query: query, headers: headers )

    json = parse_imgur_response(@results)
    render json: json
  end

  def parse_imgur_response(raw_json)
    arr = Array.new; hash = Hash.new

    parsed_data(raw_json)["data"].each do |datum|
      hash["url"] = datum["link"]
      arr << hash
    end

    arr.to_json
  end

  def parsed_data(raw_json)
    JSON.parse @results
  end
end
