RSpec.describe Discussion::Repositories::Thread do
  let(:repo) { described_class.new }
  let(:category_id) { repo.categories.insert(name: "test") }
  let(:thread) do
    id = repo.threads.insert(category_id:)
    repo.threads.by_pk(id).one!
  end

  let(:profile) do
    id = repo.profiles.insert(nickname: "hans", message_count: 17)
    repo.profiles.by_pk(id).one!
  end

  describe "handle" do
    context "ReplyAddedToThread" do
      it "creates new message in thread" do
        event = Discussion::Events::ReplyAddedToThread.new(thread_id: thread.id, author: profile, content: "test")
        repo.handle(event)
        messages = repo.messages.where(thread_id: thread.id).to_a

        expect(messages.length).to eq(1)
        expect(messages.first.text).to eq("test")
      end

      it "updates last_message_id of the thread" do
        event = Discussion::Events::ReplyAddedToThread.new(thread_id: thread.id, author: profile, content: "test")
        repo.handle(event)
        message = repo.messages.where(thread_id: thread.id).one!
        record = repo.threads.by_pk(thread.id).one!

        expect(record.last_message_id).to eq(message.id)
      end

      it "recalculates message counter" do
        event = Discussion::Events::ReplyAddedToThread.new(thread_id: thread.id, author: profile, content: "test")
        repo.handle(event)
        reloaded_profile = repo.profiles.by_pk(profile.id).one!
        expect(reloaded_profile.message_count).to eq(1)
      end
    end

    context "ThreadCreated" do
      it "creates a new thread" do
        event = Discussion::Events::ThreadCreated.new(title: "test", category_id:, content: "content", creator: profile)
        thread = repo.handle(event)
        expect(thread.title).to eq("test")
      end

      it "adds the first message" do
        event = Discussion::Events::ThreadCreated.new(title: "test", category_id:, content: "content", creator: profile)
        thread = repo.handle(event)
        message = repo.messages.where(thread_id: thread.id).one!
        expect(message.text).to eq("content")
      end

      it "recalculates message counter" do
        event = Discussion::Events::ThreadCreated.new(title: "test", category_id:, content: "content", creator: profile)
        repo.handle(event)
        reloaded_profile = repo.profiles.by_pk(profile.id).one!
        expect(reloaded_profile.message_count).to eq(1)
      end
    end

    it "raises on unknown event" do
      expect { repo.handle(Class.new) }.to raise_error(NotImplementedError)
    end
  end
end
