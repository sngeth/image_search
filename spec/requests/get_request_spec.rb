require 'rails_helper'

RSpec.describe "GET imagesearch index" do
  let(:expected_json) do
    [{
     "url": "http://i.imgur.com/TrHZQ4n.jpg"
    }].to_json
  end

  it "can get the image URL's when given a search string" do

    json = File.read(File.join("spec", "json", "imgur_gallery.json"))
    stub_request(:get, "https://api.imgur.com/3/" +
                 "gallery/search?q=lolcats%20funny").
                 to_return(:status => 200,
                           :body => json,
                           :headers => {})

    get '/api/imagesearch/lolcats%20funny?offset=10'

    expect(WebMock).to have_requested(:get, "https://api.imgur.com/3/gallery/search")
      .with(query: {"q" => "lolcats funny"})

    expect(response.body).to eq expected_json
  end
end
