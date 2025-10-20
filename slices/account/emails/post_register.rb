module Account
  module Emails
    class PostRegister < Account::Email
      def to(**args) = args.fetch(:account).email

      def from(_) = "accounts@palaver.dev"

      def subject(_) = "Your account has been created"

      class Template < Phlex::HTML
        def initialize(account:)
          @account = account
        end

        def view_template
          h1 { "Welcome, #{@account.email}" }

          p { "Thank you for registering on Palaver!" }

          p do
            plain "In order to confirm your account, please click on the following link: "
            a(href: "#{Hanami.app["settings"].email_links_base}/account/confirm?id=#{@account.id}&token=#{@account.confirmation_token}") { "confirm account" }
            plain "."
          end
        end
      end
      self.html_template = Template
    end
  end
end
