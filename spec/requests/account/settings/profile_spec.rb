require "nokolexbor"

RSpec.describe "GET /account/settings/profile", type: :request do
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }
  let(:profile) { Factories::Discussion.profile(email: "test@test.com") }

  before do
    sign_in(id: user_id) if user_id
    get "/account/settings/profile"
    @doc = Nokolexbor::HTML(last_response.body)
  end

  describe "as a user without profile set up" do
    let(:user_id) { user.id }

    specify "I can input my nickname" do
      nickname_input = @doc.xpath("//input[@name='nickname']").first
      expect(nickname_input.attributes["disabled"]).to be_nil
    end

    specify "I see an avatar input field" do
      avatar_input = @doc.xpath("//input[@name='avatar']").first
      expect(avatar_input).not_to be_nil
    end
  end

  describe "as a user with a profile set up" do
    let(:user_id) { profile.account_id }

    specify "I see a page with my nickname included" do
      expect(last_response.body).to include(profile.nickname)
    end

    specify "I cannot edit my nickname" do
      nickname_input = @doc.xpath("//input[@name='nickname']").first
      expect(nickname_input.attributes["disabled"]).not_to be_nil
      expect(nickname_input.attributes["value"].value).to eq(profile.nickname)
    end

    specify "I see an avatar input field" do
      avatar_input = @doc.xpath("//input[@name='avatar']").first
      expect(avatar_input).not_to be_nil
    end

    specify "I see my current avatar when it is set" do
      repo = Account::Repositories::Profile.new
      avatar_data = '{"id":"test_avatar.jpg","storage":"store","metadata":{"filename":"test_avatar.jpg","size":12345,"mime_type":"image/jpeg"}}'
      repo.update(profile.id, avatar_data: avatar_data)

      get "/account/settings/profile"
      doc = Nokolexbor::HTML(last_response.body)

      avatar_img = doc.xpath("//img").first
      expect(avatar_img).not_to be_nil
      expect(avatar_img.attributes["src"].value).not_to be_empty
      expect(avatar_img.attributes["src"].value).to include("uploads")
    end
  end

  describe "as an anonymous user" do
    let(:user_id) { nil }

    specify "I'm redirected to root" do
      expect(last_response.status).to eq(302)
    end
  end
end
