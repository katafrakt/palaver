# frozen_string_literal: true

url = "/account/sign_in"
RSpec.describe "GET #{url}", type: :request do
  specify do
    get url
    expect(last_response).to be_successful
  end
end
