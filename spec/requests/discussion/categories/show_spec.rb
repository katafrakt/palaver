RSpec.describe "GET /cat/:id", type: :request do
  let(:author) { Account::Container["repositories.profile"].create(nickname: "Joshua") }
  let(:repo) { Discussion::Container["repositories.category"] }
  let(:thread_repo) { Discussion::Container["repositories.thread"] }

  specify "with no threads" do
    category = repo.create(name: "abcd")
    get "/cat/#{category.id}"

    expect(last_response).to be_successful
    expect(last_response.body).to include("No threads")
  end

  specify "with one thread" do
    category = repo.create(name: "abcd")
    thread_repo.create(title: "A test thread", content: "Testiiiing",
                       category_id: category.id, author: author)
    get "/cat/#{category.id}"

    expect(last_response).to be_successful
    expect(last_response.body).not_to include("No threads")
    expect(last_response.body).to include("A test thread")
  end
end
