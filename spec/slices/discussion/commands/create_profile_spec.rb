RSpec.describe Discussion::Commands::CreateProfile, type: :db do
  let(:account) { Fixtures::Account.user() }

  def call_command(opts = {})
    avatar = if opts[:avatar]
               file_path = File.join(Hanami.app.root, "spec", "support", "files", opts[:avatar])
               File.open(file_path)
             end

    described_class.new.call(nickname: "john", avatar:, account_id: account.id)
  end

  it "creates a profile with zero message count" do
    profile = call_command()
    expect(profile.message_count).to eq(0)
  end

  it "saves avatar data" do
    profile = call_command(avatar: "cat_small.jpg")
    avatar_data = JSON.parse(profile.avatar_data)

    expect(avatar_data["metadata"]["filename"]).to eq("cat_small.jpg")
    expect(avatar_data["metadata"]["size"]).to eq(16958)
  end

  it "uploads the avatar" do
    profile = call_command(avatar: "cat_small.jpg")
    file = profile.avatar.to_io
    expect(File.exist?(file.path)).to eq(true)
  end
end
