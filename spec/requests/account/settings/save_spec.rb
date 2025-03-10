RSpec.describe "POST /account/settings", type: :request do
  let(:url) { "/account/settings" }

  def perform_request(params = {})
    default_params = {avatar: "", current_password: "", new_password: "", new_password_confirmation: ""}
    post url, default_params.merge(params)
  end

  context "as anonymous user" do
    specify "redirect to home" do
      perform_request
      expect(last_response.status).to eq(302)
    end
  end

  context "as signed in user" do
    let(:password) { "12345678" }
    let(:user) { Fixtures::Account.user(password:) }

    before do
      Fixtures::Account.profile(user.id)
      env "rack.session", {usi: user.id}
    end

    it "shows error when new passwords do not match" do
      perform_request new_password: "123123123", new_password_confirmation: "124124124"
      expect(last_response.body).to include("passwords do not match")
    end

    it "shows error when new password is too short" do
      perform_request new_password: "123", new_password_confirmation: "123"
      expect(last_response.body).to include("size cannot be less than 8")
    end

    it "shows error when current password does not match" do
      perform_request current_password: SecureRandom.hex, new_password: "123123123", new_password_confirmation: "123123123"
      expect(last_response.body).to include("incorrect password")
    end

    it "shows error when you provide new password but not current password (when new is valid)" do
      perform_request current_password: "", new_password: "123123123", new_password_confirmation: "123123123"
      expect(last_response.body).to include("incorrect password")
    end

    it "does not update password when current password is incorrect" do
      perform_request current_password: "abcdefgh", new_password: "123123123", new_password_confirmation: "123123123"
      reloaded_user = Account::Repositories::Account.new.by_id(user.id)
      expect(Argon2::Password.verify_password("123123123", reloaded_user.password_hash)).to eq(false)
    end

    it "updates the password when correct params are passed" do
      perform_request current_password: password, new_password: "123123123", new_password_confirmation: "123123123"
      reloaded_user = Account::Repositories::Account.new.by_id(user.id)
      expect(Argon2::Password.verify_password("123123123", reloaded_user.password_hash)).to eq(true)
    end

    it "updates the avatar in the profile" do
      file_path = File.join(Hanami.app.root, "spec", "support", "files", "cat_small.jpg")
      perform_request avatar: Rack::Test::UploadedFile.new(file_path, "image/jpeg")
      profile = Account::Repositories::Profile.new.by_account_id(user.id)
      expect(profile.avatar_data).not_to be_nil
      data = JSON.parse(profile.avatar_data)
      expect(data["metadata"]["filename"]).to eq("cat_small.jpg")
    end
  end

  context "as a signed in user without a profile yet" do
    let(:password) { "12345678" }
    let(:user) { Fixtures::Account.user(password:) }

    before do
      env "rack.session", {usi: user.id}
    end

    it "updates name and avatar in the profile" do
      file_path = File.join(Hanami.app.root, "spec", "support", "files", "cat_small.jpg")
      perform_request avatar: Rack::Test::UploadedFile.new(file_path, "image/jpeg"), nickname: "John"
      profile = Account::Repositories::Profile.new.by_account_id(user.id)
      expect(profile.avatar_data).not_to be_nil
      data = JSON.parse(profile.avatar_data)
      expect(data["metadata"]["filename"]).to eq("cat_small.jpg")
      expect(profile.nickname).to eq("John")
    end
  end
end
