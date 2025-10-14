RSpec.describe "GET /", type: :request do
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }
  let(:no_profile_msg) { "You need to set up your profile to start posting" }

  context "no-profile warning" do
    specify "I don't see the no-profile warning when anonymous" do
      get "/"
      expect(last_response.body).not_to include(no_profile_msg)
    end

    specify "I see the no-profile warning when signed in without profile" do
      sign_in(user: user)
      get "/"
      expect(last_response.body).to include(no_profile_msg)
    end

    specify "I don't see the no-profile warning when signed in with profile" do
      sign_in(user: user)
      Discussion::Container["repositories.profile"].create(account_id: user.id, nickname: "janice")
      get "/"
      expect(last_response.body).not_to include(no_profile_msg)
    end
  end
end
