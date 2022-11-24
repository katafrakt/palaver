RSpec.describe Discussion::Actions::Category::Show do
  subject(:action) { described_class.new }

  after do
    Discussion::Container.unstub("repositories.categories")
  end

  describe "with no categories" do
    it "renders message about no threads" do
      category = Factory.structs[:category]
      categories_repo = double(:repo)
      expect(categories_repo).to receive(:get) { category }
      Discussion::Container.stub("repositories.categories", categories_repo)

      response = action.call({id: category.id})
      expect(response.body.first).to include("No threads")
    end
  end
end
