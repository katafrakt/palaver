RSpec.describe Discussion::Entities::CurrentUser do
  let(:anonymous) { described_class.build_anonymous }
  let(:without_profile) { described_class.build_profileless(1) }
  let(:user) do
    described_class.new(
      account_id: 1,
      profile_id: 2,
      nickname: "Johann",
      email: "johann@example.no",
      message_count: 15
    )
  end

  context "signed_in?" do
    it "returns true for user with id" do
      expect(user.signed_in?).to eq(true)
    end

    it "returns true for user without profile" do
      expect(without_profile.signed_in?).to eq(true)
    end

    it "returns false for anonymous user" do
      expect(anonymous.signed_in?).to eq(false)
    end
  end

  context "profile_set_up?" do
    it "returns true when profile_id present" do
      expect(user.profile_set_up?).to eq(true)
    end

    it "returns false for user without profile" do
      expect(without_profile.profile_set_up?).to eq(false)
    end

    it "returns false for anonymous user" do
      expect(anonymous.profile_set_up?).to eq(false)
    end
  end

  context "access control" do
    it "returns :authenticated sid when user signed in" do
      expect(user.subject_sids).to include(:authenticated)
    end

    it "returns :authenticated sid when user signed in but without profile" do
      expect(without_profile.subject_sids).to include(:authenticated)
    end

    it "does not return :authenticated sid when user is not signed in" do
      expect(anonymous.subject_sids).not_to include(:authenticated)
    end
  end
end
