RSpec.describe Account::Operations::ConfirmUser do
  include Dry::Monads[:result]

  subject(:operation) { described_class.new }
  let(:repo) { double(:repo) }
  stub(Account::Container, "repositories.account") { repo }

  it "returns failure when there is no user" do
    allow(repo).to receive(:by_id_and_token).and_return(nil)
    expect(operation.call(id: 123, token: "abc")).to eq(Failure(:user_not_found))
  end

  it "returns failure when user is already confirmed" do
    account = Factories::Account.current_user_entity(confirmed_at: Time.now)
    allow(repo).to receive(:by_id_and_token).and_return(account)
    expect(operation.call(id: 123, token: "abc")).to eq(Failure(:already_confirmed))
  end

  it "confirms user if conditions met" do
    account = Factories::Account.current_user_entity(confirmed_at: nil)
    allow(repo).to receive(:by_id_and_token).and_return(account)
    expect(repo).to receive(:confirm_user)
    expect(operation.call(id: 123, token: "abc")).to be_success
  end
end
