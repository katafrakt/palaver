RSpec.describe Discussion::Commands::CreateThread, type: :db do
  let(:repo) { Discussion::Container["repositories.thread"] }
  let(:profile_repo) { Discussion::Container["repositories.profile"] }
  let(:category) { Discussion::Container["repositories.category"].create(name: "test") }
  subject(:command) { described_class.new }
  let(:author) { profile_repo.create(nickname: "jasiek", message_count: 0) }

  it "creates a thread" do
    thread = command.call(title: "weekly update", content: "update", category_id: category.id, author:)
    thread = repo.get(thread.id)
    expect(thread).not_to be_nil
  end

  it "update author's message count" do
    expect(author.message_count).to eq(0)
    command.call(title: "weekly update", content: "update", category_id: category.id, author:)
    reloaded = profile_repo.get(author.id)
    expect(reloaded.message_count).to eq(1)
  end
end
