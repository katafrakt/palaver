RSpec.describe "POST /th/:id/reply", type: :request do
  let(:author) { Account::Container["repositories.profile"].create(nickname: "Joshua") }
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }
  let(:profile) { Account::Container["repositories.profile"].create(nickname: "Wendy", account_id: user.id) }
  let(:thread) do
    category = Discussion::Repositories::Category.new.create(name: "abcd")
    Discussion::Commands::CreateThread.new.call(title: "A test thread", content: "Testing", category_id: category.id,
                                                 author: author)
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