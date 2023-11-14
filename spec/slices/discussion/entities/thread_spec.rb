RSpec.describe Discussion::Entities::Thread do
  # TODO: acocunt_id should not be required
  let(:creator) { Discussion::Entities::Author.new(nickname: "leah", id: rand(100), account_id: 1) }
  let(:thread) { described_class.new(id: rand(100), creator:, title: "My test thread") }

  context "add_reply" do
    it "returns the event" do
      event = thread.add_reply(author: creator, content: "Let's do this!")
      expect(event).to be_kind_of(Discussion::Events::ReplyAddedToThread)
      expect(event.thread_id).to eq(thread.id)
      expect(event.content).to eq("Let's do this!")
    end
  end
end
