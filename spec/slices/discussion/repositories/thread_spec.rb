RSpec.describe Discussion::Repositories::Thread do
  let(:repo) { described_class.new }
  let(:category) do
    id = repo.categories.insert(name: "test")
    repo.categories.by_pk(id).one
  end
  let(:thread) do
    id = repo.threads.insert(category_id: category.id)
    repo.threads.by_pk(id).one!
  end

  let(:profile) do
    id = repo.profiles.insert(nickname: "hans", message_count: 17)
    repo.profiles.by_pk(id).one!
  end

  context "add_reply" do
    it "creates new message in thread" do
      repo.add_reply(thread:, author: profile, content: "test")
      messages = repo.messages.where(thread_id: thread.id).to_a

      expect(messages.length).to eq(1)
      expect(messages.first.text).to eq("test")
    end

    it "updates last_message_id of the thread" do
      repo.add_reply(thread:, author: profile, content: "test")
      message = repo.messages.where(thread_id: thread.id).one!
      record = repo.threads.by_pk(thread.id).one!

      expect(record.last_message_id).to eq(message.id)
    end

    it "recalculates message counter" do
      repo.add_reply(thread:, author: profile, content: "test")
      reloaded_profile = repo.profiles.by_pk(profile.id).one!
      expect(reloaded_profile.message_count).to eq(1)
    end
  end

  context "create" do
    it "creates a new thread" do
      thread = repo.create(title: "test", category:, content: "content", creator: profile)
      expect(thread.title).to eq("test")
    end

    it "adds the first message" do
      thread = repo.create(title: "test", category:, content: "content", creator: profile)
      message = repo.messages.where(thread_id: thread.id).one!
      expect(message.text).to eq("content")
    end

    it "recalculates message counter" do
      repo.create(title: "test", category:, content: "content", creator: profile)
      reloaded_profile = repo.profiles.by_pk(profile.id).one!
      expect(reloaded_profile.message_count).to eq(1)
    end
  end
end
