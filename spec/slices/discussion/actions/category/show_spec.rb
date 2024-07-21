RSpec.describe Discussion::Actions::Category::Show do
  subject(:action) { described_class.new }
  let(:repo) { Discussion::Container["repositories.category"] }

  let(:category) do
    id = repo.categories.insert(name: "test")
    repo.categories.by_pk(id).one!
  end

  describe "with no threads" do
    it "renders message about no threads" do
      response = action.call({id: category_slug(category)})
      expect(response.body.first).to include("No threads")
    end
  end

  describe "with threads" do
    before do
      repo.threads.insert(category_id: category.id, title: "test thread")
    end

    it "renders message about no threads" do
      response = action.call({id: category_slug(category)})
      expect(response.body.first).to include("test thread")
    end
  end
end
