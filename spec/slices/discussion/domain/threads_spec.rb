RSpec.describe Discussion::Domain::Threads do
  # TODO: acocunt_id should not be required
  let(:creator) { Discussion::Entities::Author.new(nickname: "leah", id: rand(100), account_id: 1) }
  let(:thread) { Discussion::Entities::Thread.new(id: rand(100), creator:, title: "My test thread") }
  let(:threads) { Discussion::Container["domain.threads"] }

  context "add_reply" do
    it "returns the event" do
      result = threads.add_reply(thread, author: creator, content: "Let's do this!")
      expect(result).to be_success
      event = result.value!

      expect(event).to be_kind_of(Discussion::Events::ReplyAddedToThread)
      expect(event.thread_id).to eq(thread.id)
      expect(event.content).to eq("Let's do this!")
    end
  end

  context "start_thread" do
    let(:category) { Discussion::Entities::Category.new(id: rand(100), name: "Test category", thread_count: 1, message_count: 1) }

    it "returns the event" do
      event = threads.start_thread(category:, creator:, title: "Good thread", content: "This is good")

      expect(event).to be_kind_of(Discussion::Events::ThreadCreated)
      expect(event.category_id).to eq(category.id)
      expect(event.title).to eq("Good thread")
      expect(event.content).to eq("This is good")
    end
  end
end
