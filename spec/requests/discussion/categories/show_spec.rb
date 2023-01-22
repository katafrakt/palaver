RSpec.describe "GET /cat/:id", type: :request do
  let(:author) { Account::Container["repositories.profile"].create(nickname: "Joshua") }

  specify "with no threads" do
    category = Discussion::Repositories::Categories.new.create(name: "abcd")
    get "/cat/#{category.id}"

    expect(last_response).to be_successful
    expect(last_response.body).to include("No threads")
  end

  specify "with one thread" do
    category = Discussion::Repositories::Categories.new.create(name: "abcd")
    Discussion::Repositories::Threads.new.create(title: "A test thread", content: "Testiiiing",
                                                 category_id: category.id, author: author)
    get "/cat/#{category.id}"

    expect(last_response).to be_successful
    expect(last_response.body).not_to include("No threads")
    expect(last_response.body).to include("A test thread")
  end
end
