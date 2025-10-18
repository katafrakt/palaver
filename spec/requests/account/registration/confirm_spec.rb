RSpec.describe "GET /account/confirm", type: :request do
  let(:url) { "/account/confirm" }
  let(:register) { Account::Container["operations.register"] }
  let(:confirm_user) { Account::Container["operations.confirm_user"] }

  context "with valid token" do
    let(:account) { register.call(email: "test@example.com", password: "12345678").value! }

    specify "I am redirected to sign in page with success message" do
      get url, {id: account.id, token: account.confirmation_token}

      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to eq("/account/sign_in")
      follow_redirect!
      expect(last_response.body).to include("User confirmed. You can now sign in.")
    end

    specify "user is marked as confirmed", db: true do
      get url, {id: account.id, token: account.confirmation_token}

      repo = Account::Container["repositories.account"]
      confirmed_account = repo.by_id(account.id)
      expect(confirmed_account.confirmed_at).not_to be_nil
    end
  end

  context "with invalid token" do
    let(:account) { register.call(email: "test@example.com", password: "12345678").value! }

    specify "I am redirected to root with error message" do
      get url, {id: account.id, token: "invalid_token"}

      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to eq("/")
      follow_redirect!
      expect(last_response.body).to include("Incorrect confirmation link")
    end

    specify "user is not marked as confirmed", db: true do
      get url, {id: account.id, token: "invalid_token"}

      repo = Account::Container["repositories.account"]
      unconfirmed_account = repo.by_id(account.id)
      expect(unconfirmed_account.confirmed_at).to be_nil
    end
  end

  context "with non-existing id" do
    specify "I am redirected to root with error message" do
      get url, {id: 99999, token: "some_token"}

      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to eq("/")
      follow_redirect!
      expect(last_response.body).to include("Incorrect confirmation link")
    end
  end

  context "with already confirmed user" do
    let(:account) { register.call(email: "test@example.com", password: "12345678").value! }

    before do
      confirm_user.call(id: account.id, token: account.confirmation_token)
    end

    specify "I am redirected to root with error message" do
      get url, {id: account.id, token: account.confirmation_token}

      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to eq("/")
      follow_redirect!
      expect(last_response.body).to include("User is already confirmed")
    end
  end

  context "with missing parameters" do
    specify "I get error when id is missing" do
      get url, {token: "some_token"}

      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to eq("/")
      follow_redirect!
      expect(last_response.body).to include("Incorrect confirmation link")
    end

    specify "I get error when token is missing" do
      get url, {id: 123}

      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to eq("/")
      follow_redirect!
      expect(last_response.body).to include("Incorrect confirmation link")
    end

    specify "I get error when both parameters are missing" do
      get url

      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to eq("/")
      follow_redirect!
      expect(last_response.body).to include("Incorrect confirmation link")
    end
  end
end
