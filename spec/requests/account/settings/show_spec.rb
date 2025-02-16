require "nokolexbor"

RSpec.describe "GET /account/settings", type: :request do
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }
  let(:profile) { Fixtures::Discussion.profile(account_id: user.id) }

  before do
    env "rack.session", {usi: user_id}
    get "/account/settings"
    @doc = Nokolexbor::HTML(last_response.body)
  end

  describe "as a user without profile set up" do
    let(:user_id) { user.id }
    specify "I can input my nickname" do
      nickname_input = @doc.xpath("//input[@name='nickname']").first
      expect(nickname_input.attributes["disabled"]).to be_nil
    end

    specify "I cannot change my email" do
      nickname_input = @doc.xpath("//input[@name='email']").first
      expect(nickname_input.attributes["disabled"]).not_to be_nil
    end
  end

  describe "as a user with a profile set up" do
    let(:user_id) { profile.account_id }

    specify "I see a page with my nickname included" do
      get "/account/settings"
      expect(last_response.body).to include(profile.nickname)
    end

    specify "I cannot input my nickname" do
      nickname_input = @doc.xpath("//input[@name='nickname']").first
      expect(nickname_input.attributes["disabled"]).not_to be_nil
    end

    specify "I cannot change my email" do
      nickname_input = @doc.xpath("//input[@name='email']").first
      expect(nickname_input.attributes["disabled"]).not_to be_nil
    end
  end
end
