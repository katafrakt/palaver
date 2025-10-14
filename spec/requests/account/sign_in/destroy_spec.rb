# frozen_string_literal: true

RSpec.describe "GET /sign_out", type: :request do
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }

  specify "removes user id from session" do
    sign_in(user: user)
    get "/account/sign_out"
    expect(last_response.headers["Location"]).to eq("/")
    expect(last_request.session[:usi]).to be_nil
  end
end
