RSpec.describe "GET /th/:id", type: :request do
  let(:author) { Account::Container["repositories.profile"].create(nickname: "Joshua") }
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }
  let(:thread) do
    category = Discussion::Repositories::Categories.new.create(name: "abcd")
    Discussion::Repositories::Threads.new.create(title: "A test thread", content: "Testing", category_id: category.id,
                                                 author: author)
  end

  describe "as anonymous user" do
    specify "shows title and first message" do
      get "/th/#{thread.id}"
      expect(last_response.body).to include("A test thread")
      expect(last_response.body).to include("Testing")
    end

    specify "does not display reply form" do
      get "/th/#{thread.id}"
      expect(last_response.body).not_to include("Write your reply")
    end
  end

  describe "as a signed in user" do
    specify "displays reply form" do
      env "rack.session", { usi: user.id }
      get "/th/#{thread.id}"

      expect(last_response.body).to include("A test thread")
      expect(last_response.body).to include("Testing")
      expect(last_response.body).to include("Write your reply")
    end
  end
end
