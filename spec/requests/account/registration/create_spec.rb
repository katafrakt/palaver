RSpec.describe "POST /account/register", type: :request do
  let(:params) do
    {
      email: "test@example.net",
      password: "12345678",
      password_confirmation: "12345678"
    }
  end
  let(:url) { "/account/register" }

  context "errors" do
    specify "with missing email" do
      params.merge!(email: nil)
      post url, params

      expect(last_response).not_to be_successful
      expect(last_response.body).to include("must be filled")
    end

    specify "with incorrect email" do
      params.merge!(email: "abc@")
      post url, params

      expect(last_response).not_to be_successful
      expect(last_response.body).to include("is in invalid format")
    end

    specify "with missing password" do
      params.merge!(password: nil)
      post url, params

      expect(last_response).not_to be_successful
      expect(last_response.body).to include("must be filled")
    end

    specify "with missing password confirmation" do
      params.merge!(password_confirmation: nil)
      post url, params

      expect(last_response).not_to be_successful
      expect(last_response.body).to include("must be filled")
    end

    specify "with password too short" do
      params.merge!(password: "123")
      post url, params

      expect(last_response).not_to be_successful
      expect(last_response.body).to include("size cannot be less than 8")
    end

    specify "with password and confirmation not matching" do
      params.merge!(password: "12344321")
      post url, params

      expect(last_response).not_to be_successful
      expect(last_response.body).to include("passwords do not match")
    end

    specify "with email already taken", db: true do
      Account::Repositories::Account.new.create(email: "test@test.com")
      params.merge!(email: "test@test.com")
      post url, params

      expect(last_response).not_to be_successful
      expect(last_response.body).to include("must be unique")
    end
  end

  context "success", db: true do
    it "renders a message" do
      post url, params
      expect(last_response).to be_successful
      expect(last_response.body).to include("Thank you for registering")
    end
  end
end
