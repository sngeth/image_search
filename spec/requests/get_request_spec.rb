require 'rails_helper'

RSpec.describe "GET requests", type: :request do
  describe "GET api/imagesearch" do
    before(:each) do
      json = File.read(File.join("spec", "json", "imgur_gallery.json"))
      stub_request(:get, "https://api.imgur.com/3/" +
                   "gallery/search?q=lolcats%20funny").
                   to_return(:status => 200,
                             :body => json,
                             :headers => {})

    end

    let(:expected_json) do
      [{
        "url": "http://i.imgur.com/TrHZQ4n.jpg"
      }].to_json
    end

    it "can get the image URL's when given a search string" do
      get '/api/imagesearch/lolcats%20funny?offset=10'
      expect(WebMock).to have_requested(:get, "https://api.imgur.com/3/gallery/search")
        .with(query: {"q" => "lolcats funny"})

      expect(response.body).to eq expected_json
    end

    it "can create a new search record " do
      get '/api/imagesearch/lolcats%20funny?offset=10'
      expect(Search.first.term).to eq "lolcats funny"

      get '/imagesearch/latest.json'
      latest_results = Search.all.to_json
      expect(response.body).to eq latest_results
    end
  end
end
