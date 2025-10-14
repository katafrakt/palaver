# frozen_string_literal: true

url = "/account/sign_in"
RSpec.describe "GET #{url}", type: :request do
  specify "I can access the sign in page" do
    get url
    expect(last_response).to be_successful
  end

  specify "I am redirected away when already signed in" do
    user = Factories::Account.user
    sign_in(user: user)
    get url
    expect(last_response.status).to eq(302)
  end
end
