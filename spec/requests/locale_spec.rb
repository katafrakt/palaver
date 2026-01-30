# frozen_string_literal: true

POLISH_HOME = "Strona główna"
ENGLISH_HOME = "Home"

RSpec.describe "Locale detection", type: :request do
  describe "URL parameter" do
    it "sets locale from URL param and saves to cookie" do
      get "/?lang=pl"

      expect(last_response).to be_successful
      expect(last_response.body).to include(POLISH_HOME)
      expect(last_response.body).not_to include(ENGLISH_HOME)
      cookies = last_response.headers["Set-Cookie"]
      expect(cookies).to be_an(Array)
      expect(cookies.any? { |c| c.include?("locale=pl") }).to be true
    end

    it "ignores invalid locale in URL param and uses default" do
      get "/?lang=invalid"

      expect(last_response).to be_successful
      expect(last_response.body).to include(ENGLISH_HOME)
      cookies = last_response.headers["Set-Cookie"]
      expect(cookies).not_to include("locale=invalid")
    end
  end

  describe "Cookie" do
    it "uses locale from cookie when no URL param" do
      set_cookie("locale=pl")
      get "/"

      expect(last_response).to be_successful
      expect(last_response.body).to include(POLISH_HOME)
      expect(last_response.body).not_to include(ENGLISH_HOME)
    end
  end

  describe "Accept-Language header" do
    it "detects locale from browser header" do
      header "Accept-Language", "pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7"
      get "/"

      expect(last_response).to be_successful
      expect(last_response.body).to include(POLISH_HOME)
      expect(last_response.body).not_to include(ENGLISH_HOME)
    end

    it "falls back to default when header has no matching locale" do
      header "Accept-Language", "de-DE,de;q=0.9"
      get "/"

      expect(last_response).to be_successful
      expect(last_response.body).to include(ENGLISH_HOME)
    end
  end

  describe "Default locale" do
    it "uses default locale when no param, cookie, or header" do
      get "/"

      expect(last_response).to be_successful
      expect(last_response.body).to include(ENGLISH_HOME)
    end
  end
end
