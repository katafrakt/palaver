RSpec.describe "POST /account/settings/profile", type: :request do
  def perform_request(params = {})
    default_params = {avatar: ""}
    post "/account/settings/profile", default_params.merge(params)
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

    it "updates the avatar in the profile" do
      file_path = File.join(Hanami.app.root, "spec", "support", "files", "cat_small.jpg")
      perform_request avatar: Rack::Test::UploadedFile.new(file_path, "image/jpeg")
      profile = Account::Repositories::Profile.new.by_account_id(user.id)
      expect(profile.avatar_data).not_to be_nil
      data = JSON.parse(profile.avatar_data)
      expect(data["metadata"]["filename"]).to eq("cat_small.jpg")
    end
  end
end
