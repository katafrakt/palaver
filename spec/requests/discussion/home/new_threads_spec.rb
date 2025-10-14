require "nokolexbor"

RSpec.describe "GET /new_threads", type: :request do
  let(:profile) { Factories::Discussion.profile(email: "profile@test.com") }
  let(:create_thread) { Discussion::Container["commands.create_thread"] }
  let(:repo) { Discussion::Container["repositories.category"] }
  let(:category) { repo.create(name: "abcd") }

  specify "I see threads ordered by last message date" do
    th1 = Factories::Discussion.thread(title: "test 1", category:, author: profile)
    th2 = Factories::Discussion.thread(title: "test 2", category:, author: profile)
    th3 = Factories::Discussion.thread(title: "test 3", category:, author: profile)
    Factories::Discussion.message(content: "test", author: profile, thread: th3)
    Factories::Discussion.message(content: "test", author: profile, thread: th2)

    get "/new_threads"

    expect(last_response).to be_successful
    doc = Nokolexbor::HTML(last_response.body)
    titles = doc.css(".thread-row").map do |row|
      row.at_css("h4 a").text
    end
    expect(titles).to eq([th3.title, th2.title, th1.title])
  end
end
