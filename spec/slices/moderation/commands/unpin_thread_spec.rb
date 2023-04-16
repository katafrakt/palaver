RSpec.describe Moderation::Commands::UnpinThread do
  let(:category) { Fixtures::Discussion.category }
  let(:profile) { Fixtures::Discussion.profile }
  let(:thread) do
    Fixtures::Discussion.thread(category_id: category.id, author: profile).tap do |th|
      repo.pin(th.id)
    end
  end
  let(:repo) { Moderation::Container["repositories.thread"] }

  it "sets the thread as pinned" do
    described_class.new.call(thread_id: thread.id, moderator: profile)
    th = repo.get(thread.id)
    expect(th.pinned).to eq(false)
  end
end
