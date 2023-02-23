RSpec.describe Discussion::Entities::CurrentUser do
  subject(:entity) { described_class }

  context "signed_in?" do
    it "returns true for user with id" do
      expect(entity.new(id: 123).signed_in?).to eq(true)
    end

    it "returns false for user without id" do
      expect(entity.new.signed_in?).to eq(false)
    end
  end

  context "profile_set_up?" do
    it "returns true when profile_id present" do
      expect(entity.new(profile_id: 11).profile_set_up?).to eq(true)
    end

    it "returns false when profile_id is nil" do
      expect(entity.new(profile_id: nil).profile_set_up?).to eq(false)
    end

    it "returns false when profile_id is not set" do
      expect(entity.new.profile_set_up?).to eq(false)
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
