# frozen_string_literal: true

url = "/account/sign_in"
RSpec.describe "GET #{url}", type: :request do
  let(:register) { Account::Container["operations.register"] }
  let(:confirm_user) { Account::Container["operations.confirm_user"] }

  it "redirects when user not found" do
    post url, {email: "test@test.com", password: "12345678"}
    expect(last_response.status).to eq(302)
    expect(last_response.headers["Location"]).to eq("/account/sign_in")
  end

  it "renders error message and login form" do
    post url, {email: "test@test.com", password: "12345678"}
    follow_redirect!
    expect(last_response).to be_successful
    expect(last_response.body).to include("Incorrect email or password")
  end

  context "with successful login" do
    before do
      account = register.call(email: "test@test.com", password: "12345678").value!
      confirm_user.call(id: account.id, token: account.confirmation_token)
    end

    it "redirects when user is correct" do
      post url, {email: "test@test.com", password: "12345678"}
      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to eq("/")
    end

    it "renders success message on successful sign in" do
      post url, {email: "test@test.com", password: "12345678"}
      follow_redirect!
      expect(last_response).to be_successful
      expect(last_response.body).to include("Successfully signed in")
    end
  end
end
