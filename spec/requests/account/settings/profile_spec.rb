require "nokolexbor"

RSpec.describe "GET /account/settings/profile", type: :request do
  specify "I see an avatar input field" do
    user = Account::Container["repositories.account"].create(email: "test@test.com")
    Fixtures::Discussion.profile(email: "test@test.com")

    sign_in(user: user)
    get "/account/settings/profile"
    expect(last_response.status).to eq(200)

    doc = Nokolexbor::HTML(last_response.body)
    avatar_input = doc.xpath("//input[@name='avatar']").first
    expect(avatar_input).not_to be_nil
  end
end
