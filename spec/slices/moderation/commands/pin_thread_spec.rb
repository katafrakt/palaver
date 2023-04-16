RSpec.describe Moderation::Commands::PinThread do
  let(:category) { Fixtures::Discussion.category }
  let(:profile) { Fixtures::Discussion.profile }
  let(:thread) { Fixtures::Discussion.thread(category_id: category.id, author: profile) }
  let(:repo) { Discussion::Container["repositories.thread"] }

  it "sets the thread as pinned" do
    described_class.new.call(thread_id: thread.id, moderator: profile)
    th = repo.get(thread.id)
    expect(th.pinned).to eq(true)
  end
end
