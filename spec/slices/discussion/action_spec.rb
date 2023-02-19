RSpec.describe Discussion::Action do
  describe "require_signed_in_user!" do
    let(:action) do
      Class.new(described_class) do
        require_signed_in_user!
      end
    end

    it "redirects when no signed in user" do
      res = action.new.call({})
      expect(res.status).to eq(302)
      expect(res.flash.next[:error]).not_to be_nil
      expect(res.headers["Location"]).to eq("/")
    end

    it "does not redirect then there is a user" do
      account_repo = double("user repo")
      Account::Container.stub("repositories.account", account_repo)
      expect(account_repo).to receive(:by_session_id).with(101) { Account::Entities::CurrentUser.new(id: 101) }
      
      res = action.new.call("rack.session" => {"usi" => 101})
      expect(res.status).to eq(200)
      expect(res.headers["Location"]).to be_nil
      expect(res.flash.next[:error]).to be_nil
      Account::Container.unstub("repositories.account")
    end
  end
end