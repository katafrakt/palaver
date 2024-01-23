RSpec.describe Discussion::Entities::Category do
  # TODO: acocunt_id should not be required
  let(:creator) { Discussion::Entities::Author.new(nickname: "leah", id: rand(100), account_id: 1) }
  let(:category) { described_class.new(id: rand(100), name: "Test category", thread_count: 1, message_count: 1) }

  context "create_thread" do
    it "returns the event" do
      event = category.start_thread(creator:, title: "Good thread", content: "This is good")

      expect(event).to be_kind_of(Discussion::Events::ThreadCreated)
      expect(event.category_id).to eq(category.id)
      expect(event.title).to eq("Good thread")
      expect(event.content).to eq("This is good")
    end
  end
end
