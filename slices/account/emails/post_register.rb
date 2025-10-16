module Account
  module Emails
    class PostRegister < Account::Email
      def initialize(account:)
        @account = account
      end

      def to = @account.email

      def from = "accounts@palaver.dev"

      def subject = "Your account has been created"

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

      def html_part
        Template.new(account: @account).call
      end
    end
  end
end
