module Account
  module Mailers
    class PostRegister < Mailer
      to { |email:| email }
      subject { "Welcome to Palaver!" }

      expose :email

      expose :confirmation_url do |account_id:, confirmation_token:|
        base = Hanami.app["settings"].email_links_base
        "#{base}/account/confirm?id=#{account_id}&token=#{confirmation_token}"
      end

      html_template do |input|
        h1 { "Welcome #{input[:email]}!" }

        p { "Thank you for registering on Palaver!" }

        p do
          plain "In order to confirm your account, please click on the following link: "
          a(href: input[:confirmation_url]) { "confirm account" }
          plain "."
        end
      end
    end
  end
end
