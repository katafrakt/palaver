RSpec.describe "GET /profile", type: :request do
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }
  let(:profile) { Fixtures::Discussion.profile(account_id: user.id) }

  describe "as a user without profile set up" do
    before { env "rack.session", {usi: user.id} }

    specify "I'm redirected to account settings page" do
      get "/profile"
      expect(last_response.status).to eq(302)
      expect(last_response.header["Location"]).to eq("/account/settings")
    end
  end

  describe "as a user with a profile set up" do
    before { env "rack.session", {usi: profile.account_id} }

    specify "I see a page with my nickname included" do
      get "/profile"
      expect(last_response.body).to include(profile.nickname)
    end
  end
end
