RSpec.describe "POST /account/settings/account", type: :request do
  def perform_request(params = {})
    default_params = {current_password: "", new_password: "", new_password_confirmation: ""}
    post "/account/settings/account", default_params.merge(params)
  end

  context "as anonymous user" do
    specify "I am redirected to home" do
      perform_request
      expect(last_response.status).to eq(302)
    end
  end

  context "as signed in user" do
    let(:password) { "12345678" }
    let(:user) { Fixtures::Account.user(password:) }

    before do
      Fixtures::Account.profile(user.id)
      sign_in(user: user)
    end

    specify "I see an error when new passwords do not match" do
      perform_request new_password: "123123123", new_password_confirmation: "124124124"
      expect(last_response.body).to include("passwords do not match")
    end

    specify "I see an error when new password is too short" do
      perform_request new_password: "123", new_password_confirmation: "123"
      expect(last_response.body).to include("size cannot be less than 8")
    end

    specify "I see an error when current password does not match" do
      perform_request current_password: SecureRandom.hex, new_password: "123123123", new_password_confirmation: "123123123"
      expect(last_response.body).to include("incorrect password")
    end

    specify "I see an error when I provide new password but not current password" do
      perform_request current_password: "", new_password: "123123123", new_password_confirmation: "123123123"
      expect(last_response.body).to include("incorrect password")
    end

    specify "my password is not updated when current password is incorrect" do
      perform_request current_password: "abcdefgh", new_password: "123123123", new_password_confirmation: "123123123"
      reloaded_user = Account::Repositories::Account.new.by_id(user.id)
      expect(Argon2::Password.verify_password("123123123", reloaded_user.password_hash)).to eq(false)
    end

    specify "my password is updated when correct params are passed" do
      perform_request current_password: password, new_password: "123123123", new_password_confirmation: "123123123"
      reloaded_user = Account::Repositories::Account.new.by_id(user.id)
      expect(Argon2::Password.verify_password("123123123", reloaded_user.password_hash)).to eq(true)
    end
  end
end
