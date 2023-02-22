# frozen_string_literal: true

url = "/account/sign_in"
RSpec.describe "GET #{url}", type: :request do
  specify "return success" do
    get url
    expect(last_response).to be_successful
  end

  specify "redirect when user already signed in" do
    user = Fixtures::Account.user
    env "rack.session", { usi: user.id }
    get url
    expect(last_response.status).to eq(302)
  end
end
