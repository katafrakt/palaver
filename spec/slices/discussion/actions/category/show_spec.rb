RSpec.describe Discussion::Actions::Category::Show do
  subject(:action) { described_class.new }
  let(:repo) { double(:repo) }
  stub(Discussion::Container, "repositories.category") { repo }

  describe "with no categories" do
    it "renders message about no threads" do
      category = Factory.structs[:category]
      expect(repo).to receive(:get) { category }

      response = action.call({id: category_slug(category)})
      expect(response.body.first).to include("No threads")
    end
  end
end
