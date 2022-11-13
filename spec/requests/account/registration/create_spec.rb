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
  end
end
