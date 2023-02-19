RSpec.describe Discussion::Components::NoProfileWarning do
  include Phlex::Testing::ViewHelper

  let(:anonymous_user) { OpenStruct.new(signed_in?: false) }
  let(:signed_in_user) { OpenStruct.new(signed_in?: true) }

  it "renders nothing when user is not signed in" do
    warning = described_class.new(anonymous_user, nil)
    expect(render(warning)).to eq("")
  end

  it "renders nothing when user is signed in but without a profile" do
    warning = described_class.new(signed_in_user, nil)
    expect(render(warning)).to match("You need to set up")
  end

  it "renders warning when user is signed in and has profile" do
    warning = described_class.new(signed_in_user, Object.new)
    expect(render(warning)).to eq("")
  end
end