RSpec.describe "POST /account/settings", type: :request do
  let(:url) { "/account/settings" }

  context "as anonymous user" do
    specify "redirect to home" do
      post url, {}
      expect(last_response.status).to eq(302)
    end
  end

  context "as signed in user" do
    let(:password) { "12345678" }
    before do
      user = Fixtures::Account.user(password:)
      Fixtures::Account.profile(user.id)
      env "rack.session", {usi: user.id}
    end

    it "shows error when new passwords do not match" do
      params = {new_password: "123123123", new_password_confirmation: "124124124"}
      post url, params
      expect(last_response.body).to include("passwords do not match")
    end

    it "shows error when new password is too short" do
      params = {new_password: "123", new_password_confirmation: "123"}
      post url, params
      expect(last_response.body).to include("size cannot be less than 8")
    end

    it "shows error when current password does not match" do
      params = {current_password: SecureRandom.hex}
      post url, params
      expect(last_response.body).to include("incorrect password")
    end

    it "shows error when you provide new password but not current password (when new is valid)" do
      params = {current_password: "", new_password: "123123123", new_password_confirmation: "123123123"}
      post url, params
      p last_response.body
      expect(last_response.body).to include("incorrect password")
    end
  end
end
