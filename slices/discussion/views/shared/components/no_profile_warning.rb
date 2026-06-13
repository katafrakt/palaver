# frozen_string_literal: true

class Discussion::Views::Shared::Components::NoProfileWarning < Phlex::HTML
  def initialize(current_user)
    @current_user = current_user
  end

  def view_template
    if @current_user.signed_in? && !@current_user.profile_set_up?
      article(class: "alert alert-warning") do
        div(class: "alert-description") do
          plain "You need to set up your profile to start posting. You can do that "
          a(href: "/profile", class: "alert-link") { "here" }
          plain "."
        end
      end
    end
  end
end
