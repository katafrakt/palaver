RSpec.describe "GET /cat/:id", type: :request do
  let(:author) { Fixtures::Discussion.profile }
  let(:repo) { Discussion::Container["repositories.category"] }
  let(:thread_repo) { Discussion::Container["repositories.thread"] }

  specify "with no threads" do
    category = repo.create(name: "abcd")
    slug = category_slug(category)

    get "/cat/#{slug}"

    expect(last_response).to be_successful
    expect(last_response.body).to include("No threads")
  end

  specify "with one thread" do
    category = repo.create(name: "abcd")
    Fixtures::Discussion.thread(
      title: "A test thread", content: "Testiiiing",
      category:, author:
    )
    slug = category_slug(category)

    get "/cat/#{slug}"

    expect(last_response).to be_successful
    expect(last_response.body).not_to include("No threads")
    expect(last_response.body).to include("A test thread")
  end
end
