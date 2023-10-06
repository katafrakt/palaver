RSpec.describe Discussion::Views::Shared::Components::NoProfileWarning do
  include Phlex::Testing::ViewHelper

  let(:anonymous_user) { Discussion::Entities::CurrentUser.new }
  let(:signed_in_user_without_profile) { Discussion::Entities::CurrentUser.new(id: 11) }
  let(:signed_in_user_with_profile) { Discussion::Entities::CurrentUser.new(id: 11, profile_id: 11) }

  it "renders nothing when user is not signed in" do
    warning = described_class.new(anonymous_user)
    expect(render(warning)).to eq("")
  end

  it "renders nothing when user is signed in but without a profile" do
    warning = described_class.new(signed_in_user_without_profile)
    expect(render(warning)).to match("You need to set up")
  end

  it "renders warning when user is signed in and has profile" do
    warning = described_class.new(signed_in_user_with_profile)
    expect(render(warning)).to eq("")
  end
end
