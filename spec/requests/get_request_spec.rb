require 'rails_helper'

RSpec.describe "GET imagesearch index" do
  it "can get the image URL's when given a search string" do
    stub_request(:get, "https://api.imgur.com/3/gallery/search?q=lolcats%20funny").
      to_return(:status => 200, :body => "", :headers => {})

    get '/api/imagesearch/lolcats%20funny?offset=10'


    expect(WebMock).to have_requested(:get, "https://api.imgur.com/3/gallery/search")
      .with(query: {"q" => "lolcats funny"})
  end
end
