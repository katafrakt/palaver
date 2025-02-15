RSpec.describe Discussion::Views::Shared::Components::NoProfileWarning do
  include ComponentTestingHelper

  let(:anonymous) { Discussion::Entities::CurrentUser.build_anonymous }
  let(:without_profile) { Discussion::Entities::CurrentUser.build_profileless(1) }
  let(:user) do
    Discussion::Entities::CurrentUser.new(
      account_id: 1,
      profile_id: 2,
      nickname: "Johann",
      email: "johann@example.no",
      message_count: 15
    )
  end

  it "renders nothing when user is not signed in" do
    warning = described_class.new(anonymous)
    expect(render(warning)).to eq("")
  end

  it "renders nothing when user is signed in but without a profile" do
    warning = described_class.new(without_profile)
    expect(render(warning)).to match("You need to set up")
  end

  it "renders warning when user is signed in and has profile" do
    warning = described_class.new(user)
    expect(render(warning)).to eq("")
  end
end
