require "nokolexbor"

RSpec.describe "GET /new_threads", type: :request do
  let(:profile) { Fixtures::Discussion.profile }
  let(:create_thread) { Discussion::Container["commands.create_thread"] }
  let(:repo) { Discussion::Container["repositories.category"] }
  let(:category_id) { repo.create(name: "abcd").id }

  specify "return threads descending by last message date" do
    th1 = Fixtures::Discussion.thread(title: "test 1", category_id:, author: profile)
    th2 = Fixtures::Discussion.thread(title: "test 2", category_id:, author: profile)
    th3 = Fixtures::Discussion.thread(title: "test 3", category_id:, author: profile)
    Fixtures::Discussion.message(content: "test", author: profile, thread_id: th3.id)
    Fixtures::Discussion.message(content: "test", author: profile, thread_id: th2.id)

    get "/new_threads"

    expect(last_response).to be_successful
    doc = Nokolexbor::HTML(last_response.body)
    titles = doc.css(".thread-row").map do |row|
      row.at_css("h4 a").text
    end
    expect(titles).to eq([th3.title, th2.title, th1.title])
  end
end
