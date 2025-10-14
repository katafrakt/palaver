# frozen_string_literal: true

url = "/account/sign_in"
RSpec.describe "GET #{url}", type: :request do
  let(:register) { Account::Container["operations.register"] }
  let(:confirm_user) { Account::Container["operations.confirm_user"] }

  specify "I am redirected when user is not found" do
    post url, {email: "test@test.com", password: "12345678"}
    expect(last_response.status).to eq(302)
    expect(last_response.headers["Location"]).to eq("/account/sign_in")
  end

  specify "I see an error message when credentials are incorrect" do
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

    specify "I am redirected to home when credentials are correct" do
      post url, {email: "test@test.com", password: "12345678"}
      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to eq("/")
    end

    specify "I see a success message when I sign in successfully" do
      post url, {email: "test@test.com", password: "12345678"}
      follow_redirect!
      expect(last_response).to be_successful
      expect(last_response.body).to include("Successfully signed in")
    end
  end
end
