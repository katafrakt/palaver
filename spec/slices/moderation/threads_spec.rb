RSpec.describe Moderation::Threads do
  let(:threads) { Moderation::Container["threads"] }

  def build_thread(args = {})
    params = {id: rand(100), title: "My test thread", pinned: false}.merge(args)
    Moderation::Entities::Thread.new(params)
  end

  describe "pin" do
    it "returns success for thread" do
      expect(threads.pin(build_thread)).to be_success
    end

    it "returns correct event on success" do
      thread = build_thread
      event = threads.pin(thread).value!
      expect(event.thread_id).to eq(thread.id)
    end

    it "returns failure when thread already pinned" do
      result = threads.pin(build_thread(pinned: true))
      expect(result).to be_failure
      expect(result.failure).to eq(:thread_already_pinned)
    end
  end

  describe "unpin" do
    it "returns success for pinned thread" do
      thread = build_thread(pinned: true)
      expect(threads.unpin(thread)).to be_success
    end

    it "returns correct event on success" do
      thread = build_thread(pinned: true)
      event = threads.unpin(thread).value!
      expect(event.thread_id).to eq(thread.id)
    end

    it "returns failure for not pinned thread" do
      result = threads.unpin(build_thread)
      expect(result).to be_failure
      expect(result.failure).to eq(:thread_not_pinned)
    end
  end
end
