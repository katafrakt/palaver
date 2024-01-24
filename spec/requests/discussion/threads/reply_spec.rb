RSpec.describe "POST /th/:id/reply", type: :request do
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }
  let(:author) { Fixtures::Discussion.profile(account_id: user.id) }

  let(:thread) do
    category = Fixtures::Discussion.category
    Fixtures::Discussion.thread(category_id: category.id, author:)
  end

  describe "as a signed in user" do
    before do
      env "rack.session", {usi: user.id}
    end

    specify "redirects to the thread" do
      post "/th/#{thread_slug(thread)}/reply", reply: "This is a reply"

      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to eq("/th/#{thread_slug(thread)}")
    end
  end
end
