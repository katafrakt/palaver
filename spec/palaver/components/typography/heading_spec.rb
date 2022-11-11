RSpec.describe Palaver::Components::Typography::Heading do
  include Phlex::Testing::ViewHelper

  it "renders level 1 heading" do
    heading = described_class.new(level: 1, text: "Welcome!")
    expect(render(heading)).to eq(%(<h1 class="is-size-1">Welcome!</h1>))
  end
end
