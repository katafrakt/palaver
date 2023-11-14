RSpec.describe "GET /th/:id", type: :request do
  let(:author) { Fixtures::Discussion.profile }
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }
  let(:thread) do
    category = Discussion::Repositories::Category.new.create(name: "abcd")
    Fixtures::Discussion.thread(category_id: category.id, author:, title: "A test thread", content: "Testing")
  end

  describe "as anonymous user" do
    specify "shows title and first message" do
      get "/th/#{thread_slug(thread)}"
      expect(last_response.body).to include("A test thread")
      expect(last_response.body).to include("Testing")
    end

    specify "does not display reply form" do
      get "/th/#{thread_slug(thread)}"
      expect(last_response.body).not_to include("Write your reply")
    end
  end

  describe "as a signed in user without profile set up" do
    specify "does not display reply form" do
      env "rack.session", {usi: user.id}
      get "/th/#{thread_slug(thread)}"

      expect(last_response.body).not_to include("Write your reply")
      expect(last_response.body).to include("You need to set up your profile to start posting")
    end
  end

  describe "as a signed in user with profile set up" do
    specify "displays reply form" do
      Discussion::Container["repositories.profile"].create(nickname: "Joshua", account_id: user.id)
      env "rack.session", {usi: user.id}
      get "/th/#{thread_slug(thread)}"

      expect(last_response.body).to include("Write your reply")
    end
  end
end
