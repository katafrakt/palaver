RSpec.describe "POST /th/:id/reply", type: :request do
  let(:author) { Discussion::Container["repositories.profile"].create(nickname: "Joshua") }
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }
  let(:profile) { Discussion::Container["repositories.profile"].create(nickname: "Wendy", account_id: user.id) }
  let(:thread) do
    category = Fixtures::Discussion.category
    Fixtures::Discussion.thread(category_id: category.id, author:)
  end

  describe "as a signed in user" do
    before do
      profile
      env "rack.session", { usi: user.id }
    end

    specify "redirects to the thread" do
      post "/th/#{thread.id}/reply", reply: "This is a reply"

      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to eq("/th/#{thread.id}")
    end
  end
end
