RSpec.describe Discussion::Actions::Category::Show do
  subject(:action) { described_class.new }
  let(:repo) { double(:repo) }
  let(:query) { double(:query) }
  stub(Discussion::Container, "repositories.category") { repo }
  stub(Discussion::Container, "queries.threads_in_category") { query }

  describe "with no threads" do
    let(:category) { Factory.structs[:category] }

    before do
      expect(repo).to receive(:get) { category }
      expect(query).to receive(:call).with(category.id) { [] }
    end

    it "renders message about no threads" do
      response = action.call({id: category_slug(category)})
      expect(response.body.first).to include("No threads")
    end
  end

  describe "with threads" do
    let(:category) { Factory[:category] }
    let(:threads) { [Discussion::Entities::Thread.from_rom(category.latest_thread)] }

    before do
      expect(repo).to receive(:get) { category }
      expect(query).to receive(:call).with(category.id) { threads }
    end

    it "renders message about no threads" do
      response = action.call({id: category_slug(category)})
      threads.each { |th| expect(response.body.first).to include(th.title) }
    end
  end
end
