RSpec.describe "POST /account/settings/profile", type: :request do
  def perform_request(params = {})
    default_params = {avatar: "", nickname: ""}
    post "/account/settings/profile", default_params.merge(params)
  end

  context "as anonymous user" do
    specify "I am redirected to home" do
      perform_request
      expect(last_response.status).to eq(302)
    end
  end

  context "as signed in user without existing nickname" do
    let(:password) { "12345678" }
    let(:user) { Factories::Account.user(password:) }

    before do
      # Create a profile without a nickname
      repo = Account::Container["repositories.profile"]
      repo.create(account_id: user.id)
      sign_in(user: user)
    end

    specify "I can set my nickname" do
      perform_request nickname: "new_nickname"
      profile = Account::Repositories::Profile.new.by_account_id(user.id)
      expect(profile.nickname).to eq("new_nickname")
    end

    specify "I can update my avatar" do
      file_path = File.join(Hanami.app.root, "spec", "support", "files", "cat_small.jpg")
      perform_request avatar: Rack::Test::UploadedFile.new(file_path, "image/jpeg")
      profile = Account::Repositories::Profile.new.by_account_id(user.id)
      expect(profile.avatar_data).not_to be_nil
      data = JSON.parse(profile.avatar_data)
      expect(data["metadata"]["filename"]).to eq("cat_small.jpg")
    end

    specify "I can set both avatar and nickname" do
      file_path = File.join(Hanami.app.root, "spec", "support", "files", "cat_small.jpg")
      perform_request avatar: Rack::Test::UploadedFile.new(file_path, "image/jpeg"), nickname: "test_user"
      profile = Account::Repositories::Profile.new.by_account_id(user.id)
      expect(profile.nickname).to eq("test_user")
      expect(profile.avatar_data).not_to be_nil
    end
  end

  context "as signed in user with existing nickname" do
    let(:password) { "12345678" }
    let(:user) { Factories::Account.user(password:) }

    before do
      # Create a profile with an existing nickname
      Factories::Account.profile(user.id)
      sign_in(user: user)
    end

    specify "I cannot change my nickname" do
      perform_request nickname: "new_nickname"
      profile = Account::Repositories::Profile.new.by_account_id(user.id)
      expect(profile.nickname).to eq("test") # Should remain the original nickname
    end

    specify "I can update my avatar" do
      file_path = File.join(Hanami.app.root, "spec", "support", "files", "cat_small.jpg")
      perform_request avatar: Rack::Test::UploadedFile.new(file_path, "image/jpeg")
      profile = Account::Repositories::Profile.new.by_account_id(user.id)
      expect(profile.avatar_data).not_to be_nil
      data = JSON.parse(profile.avatar_data)
      expect(data["metadata"]["filename"]).to eq("cat_small.jpg")
    end

    specify "I can update my avatar but not my nickname" do
      file_path = File.join(Hanami.app.root, "spec", "support", "files", "cat_small.jpg")
      perform_request avatar: Rack::Test::UploadedFile.new(file_path, "image/jpeg"), nickname: "should_not_change"
      profile = Account::Repositories::Profile.new.by_account_id(user.id)
      expect(profile.nickname).to eq("test") # Should remain the original nickname
      expect(profile.avatar_data).not_to be_nil
    end
  end
end
