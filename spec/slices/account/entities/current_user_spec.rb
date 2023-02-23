RSpec.describe Account::Entities::CurrentUser do
  subject(:entity) { described_class }

  context "signed_in?" do
    it "returns true for user with id" do
      expect(entity.new(id: 123).signed_in?).to eq(true)
    end

    it "returns false for user without id" do
      expect(entity.new.signed_in?).to eq(false)
    end
  end

  context "access control" do
    it "returns :authenticated sid when user signed in" do
      expect(entity.new(id: 12).subject_sids).to include(:authenticated)
    end

    it "does not return :authenticated sid when user is not signed in" do
      expect(entity.new.subject_sids).not_to include(:authenticated)
    end
  end
end
