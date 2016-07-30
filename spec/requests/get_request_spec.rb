require 'rails_helper'

RSpec.describe "GET imagesearch index" do
  it "can get the image URL's when given a search string" do
    get '/api/imagesearch/lolcats%20funny?offset=10'
    expect(response).to have_http_status :ok
  end
end
