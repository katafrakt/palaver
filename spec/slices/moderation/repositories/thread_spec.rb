RSpec.describe Moderation::Repositories::Thread do
  let(:repo) { described_class.new }
  let(:category_id) { repo.categories.insert(name: "test") }
  let(:thread) do
    id = repo.threads.insert(category_id:)
    repo.threads.by_pk(id).one!
  end

  describe "handle" do
    context "ThreadPinned" do
      it "changes the value of pinned column" do
        event = Moderation::Events::ThreadPinned.new(thread_id: thread.id, pinned: false)
        reloaded = repo.handle(event)
        expect(reloaded.pinned).to eq(true)
      end
    end

    context "ThreadUnpinned" do
      it "changes the value of pinned column" do
        event = Moderation::Events::ThreadUnpinned.new(thread_id: thread.id, pinned: true)
        reloaded = repo.handle(event)
        expect(reloaded.pinned).to eq(false)
      end
    end

    context "ThreadLocked" do
      it "changes the value of locked column" do
        event = Moderation::Events::ThreadLocked.new(thread_id: thread.id, locked: false)
        reloaded = repo.handle(event)
        expect(reloaded.locked).to eq(true)
      end
    end

    context "ThreadUnlocked" do
      it "changes the value of locked column" do
        event = Moderation::Events::ThreadUnlocked.new(thread_id: thread.id, locked: true)
        reloaded = repo.handle(event)
        expect(reloaded.locked).to eq(false)
      end
    end
  end

  it "raises on unknown event" do
    expect { repo.handle(Class.new) }.to raise_error(NotImplementedError)
  end
end
