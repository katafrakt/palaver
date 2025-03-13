RSpec.describe Discussion::Operations::StartThread do
  let(:operation) { described_class.new }
  let(:title) { "Test thread" }
  let(:content) { "This is the body" }
  let(:creator) { double(:creator) }

  it "returns failure when category does not exist" do
    response = operation.call(category_id: 100, title:, content:, creator:)
    expect(response).to be_failure
    expect(response.failure).to eq(:category_not_found)
  end
end
