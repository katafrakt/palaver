module Account
  module Emails
    class PostRegister < Account::Email
      def to = nil

      def from = "accounts@palaver.dev"

      def subject = "Your account has been created"

      def build(account:)
        super.tap do |mail|
          mail.to = account.email
        end
      end

      class Template < Phlex::HTML
        def initialize(account:)
          @account = account
        end

        def view_template
          h1 { "Welcome, #{@account.email}" }

          p { "Thank you for registering on Palaver!" }

          p do
            plain "In order to confirm your account, please click on the following link: "
            a(href: "http://localhost:2300/account/confirm?id=#{@account.id}&token=#{@account.confirmation_token}") { "confirm account" }
            plain "."
          end
        end
      end
      self.html_template = Template
    end
  end
end
