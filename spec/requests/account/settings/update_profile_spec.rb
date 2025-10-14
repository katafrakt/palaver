RSpec.describe "POST /account/settings/profile", type: :request do
  def perform_request(params = {})
    default_params = {avatar: ""}
    post "/account/settings/profile", default_params.merge(params)
  end

  context "as anonymous user" do
    specify "I am redirected to home" do
      perform_request
      expect(last_response.status).to eq(302)
    end
  end

  context "as signed in user" do
    let(:password) { "12345678" }
    let(:user) { Factories::Account.user(password:) }

    before do
      Factories::Account.profile(user.id)
      sign_in(user: user)
    end

    specify "I can update my avatar" do
      file_path = File.join(Hanami.app.root, "spec", "support", "files", "cat_small.jpg")
      perform_request avatar: Rack::Test::UploadedFile.new(file_path, "image/jpeg")
      profile = Account::Repositories::Profile.new.by_account_id(user.id)
      expect(profile.avatar_data).not_to be_nil
      data = JSON.parse(profile.avatar_data)
      expect(data["metadata"]["filename"]).to eq("cat_small.jpg")
    end
  end
end
