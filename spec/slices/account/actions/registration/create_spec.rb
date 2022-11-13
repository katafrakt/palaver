RSpec.describe Account::Actions::Registration::Create do
  let(:params) do
    {
      email: "test@example.net",
      password: "12345678",
      password_confirmation: "12345678"
    }
  end

  describe "errors" do
    it "errors with missing password" do
    end
  end
end
