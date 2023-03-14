RSpec.describe "GET /", type: :request do
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }
  let(:no_profile_msg) { "You need to set up your profile to start posting" }

  describe "no-profile warning" do
    specify "anonymous user does not see it" do
      get "/"
      expect(last_response.body).not_to include(no_profile_msg)
    end

    specify "signd in user without profile sees it" do
      env "rack.session", {usi: user.id}
      get "/"
      expect(last_response.body).to include(no_profile_msg)
    end

    specify "signed in user with profile does not see it" do
      env "rack.session", {usi: user.id}
      Discussion::Container["repositories.profile"].create(account_id: user.id, nickname: "janice")
      get "/"
      expect(last_response.body).not_to include(no_profile_msg)
    end
  end
end
