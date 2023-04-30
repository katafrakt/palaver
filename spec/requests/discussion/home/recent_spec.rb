require "nokolexbor"

RSpec.describe "GET /recent", type: :request do
  let(:profile) do
    Discussion::Container["commands.create_profile"].call(nickname: "john", avatar: nil, account_id: 1).value!
  end
  let(:create_thread) { Discussion::Container["commands.create_thread"] }
  let(:add_message) { Discussion::Container["commands.add_message"] }
  let(:repo) { Discussion::Container["repositories.category"] }
  let(:category_id) { repo.create(name: "abcd").id }

  specify "return threads descending by last message date" do
    th1 = create_thread.call(title: "test 1", content: "test", category_id:, author: profile).value!
    th2 = create_thread.call(title: "test 2", content: "test", category_id:, author: profile).value!
    th3 = create_thread.call(title: "test 3", content: "test", category_id:, author: profile).value!
    add_message.call(content: "test", author: profile, thread: th3)
    add_message.call(content: "test", author: profile, thread: th2)

    get "/recent"

    expect(last_response).to be_successful
    doc = Nokolexbor::HTML(last_response.body)
    titles = doc.css(".thread-row").map do |row|
      row.at_css("h4 a").text
    end
    expect(titles).to eq([th2.title, th3.title, th1.title])
  end
end
