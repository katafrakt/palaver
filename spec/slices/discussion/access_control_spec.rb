RSpec.describe Discussion::AccessControl do
  subject(:acl) { Discussion::Container["access_control"].authorizer }
  let(:thread_model) { Discussion::Entities::Thread }

  it "disallows anonymous user to reply" do
    current_user = Account::Entities::AnonymousUser.new
    thread = thread_model.new(id: 15, category_id: 15, title: "test thread", first_message_id: 1, last_message_id: 1,
      pinned: false, locked: false)
    expect(acl.authorized?(current_user, thread, :reply)).to eq(false)
  end

  it "allows authorized user to reply" do
    current_user = Account::Entities::CurrentUser.new(id: 1, email: "test@test.com")
    thread = thread_model.new(id: 15, category_id: 15, title: "test thread", first_message_id: 1, last_message_id: 1,
      pinned: false, locked: false)
    expect(acl.authorized?(current_user, thread, :reply)).to eq(true)
  end
end
