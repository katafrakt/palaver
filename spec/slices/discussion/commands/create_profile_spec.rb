RSpec.describe Discussion::Commands::CreateProfile, type: :db do
  let(:account) { Fixtures::Account.user() }
  subject(:command) { described_class.new }

  it "creates a profile with zero message count" do
    profile = command.call(nickname: "john", avatar: nil, account_id: account.id)
    expect(profile.message_count).to eq(0)
  end

  it "saves avatar data" do
    file_path = File.join(Hanami.app.root, "spec", "support", "files", "cat_small.jpg")
    file = File.open(file_path)
    profile = command.call(nickname: "john", avatar: file, account_id: account.id)
    avatar_data = JSON.parse(profile.avatar_data)

    expect(avatar_data["metadata"]["filename"]).to eq("cat_small.jpg")
    expect(avatar_data["metadata"]["size"]).to eq(16958)
  end

  it "uploads the avatar" do
    file_path = File.join(Hanami.app.root, "spec", "support", "files", "cat_small.jpg")
    file = File.open(file_path)
    profile = command.call(nickname: "john", avatar: file, account_id: account.id)

    file = profile.avatar.to_io
    expect(File.exist?(file.path)).to eq(true)
  end
end
