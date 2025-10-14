# frozen_string_literal: true

url = "/account/register"
RSpec.describe "GET #{url}", type: :request do
  specify "I can access the registration page" do
    get url
    expect(last_response).to be_successful
  end
end
