RSpec.describe Discussion::Utils::ThreadIndexer do
  subject(:indexer) { described_class.new }
  let(:id) { Faker::Number.unique.number }
  let(:pager) { double('pager') }
  let(:message) { double('message', id: id) }

  before do
    expect(pager).to receive(:per_page) { 15 }
  end

  context "on the first page" do
    before do
      expect(pager).to receive(:current_page) { 1 }
    end

    it "returns 1 for the first entry" do
      expect(pager).to receive(:entries) { [message, *2.times.map{ double('message', id: Faker::Number.unique.number) }] }

      expect(indexer.(pager, message)).to eq 1
    end

    it "returns 15 for the _per_page_th entry" do
      expect(pager).to receive(:entries) { [*14.times.map{ double('message', id: Faker::Number.unique.number) }, message] }

      expect(indexer.(pager, message)).to eq 15
    end
  end

  context "on the 5th page" do
    before do
      expect(pager).to receive(:current_page) { 5 }
    end

    it "returns 61 for the first entry" do
      expect(pager).to receive(:entries) { [message, *2.times.map{ double('message', id: Faker::Number.unique.number) }] }

      expect(indexer.(pager, message)).to eq 61
    end

    it "returns 63 for the third entry" do
      expect(pager).to receive(:entries) { [*2.times.map{ double('message', id: Faker::Number.unique.number) }, message, *2.times.map{ double('message', id: Faker::Number.unique.number) }] }

      expect(indexer.(pager, message)).to eq 63
    end

    it "returns 75 for the _per_page_th entry" do
      expect(pager).to receive(:entries) { [*14.times.map{ double('message', id: Faker::Number.unique.number) }, message] }

      expect(indexer.(pager, message)).to eq 75
    end
  end
end
