RSpec.describe "GET /th/:id", type: :request do
  let(:author) { Fixtures::Discussion.profile }
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }
  let(:thread) do
    category = Discussion::Repositories::Category.new.create(name: "abcd")
    Fixtures::Discussion.thread(category:, author:, title: "A test thread", content: "Testing")
  end

  context "as anonymous user" do
    specify "I can see the thread title and content" do
      get "/th/#{thread_slug(thread)}"
      expect(last_response.body).to include("A test thread")
      expect(last_response.body).to include("Testing")
    end

    specify "I don't see a reply form" do
      get "/th/#{thread_slug(thread)}"
      expect(last_response.body).not_to include("Write your reply")
    end
  end

  context "as a signed in user without profile set up" do
    specify "I don't see a reply form but see profile setup message" do
      sign_in(user: user)
      get "/th/#{thread_slug(thread)}"

      expect(last_response.body).to include("You need to set up your profile to start posting")
      expect(last_response.body).not_to include("Write your reply")
    end
  end

  context "as a signed in user with profile set up" do
    specify "I can see a reply form" do
      Discussion::Container["repositories.profile"].create(nickname: "Joshua", account_id: user.id)
      sign_in(user: user)
      get "/th/#{thread_slug(thread)}"

      expect(last_response.body).to include("Write your reply")
    end
  end
end
