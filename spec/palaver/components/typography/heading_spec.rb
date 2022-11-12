RSpec.describe Palaver::Components::Typography::Heading do
  include Phlex::Testing::ViewHelper

  it "renders level 1 heading" do
    heading = described_class.new(level: 1, text: "Welcome!")
    expect(render(heading)).to eq(%(<h1 class="is-size-1">Welcome!</h1>))
  end

  it "renders level 2 heading" do
    heading = described_class.new(level: 2, text: "Welcome!")
    expect(render(heading)).to eq(%(<h2 class="is-size-2 pb-3 mb-3">Welcome!</h2>))
  end

  it "renders level 3 heading by default" do
    heading = described_class.new(level: 3, text: "Welcome!")
    expect(render(heading)).to eq(%(<h3 class="is-size-3">Welcome!</h3>))
  end
end
