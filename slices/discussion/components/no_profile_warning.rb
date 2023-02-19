class Discussion::Components::NoProfileWarning < Phlex::HTML
  def initialize(current_user, current_profile)
    @current_user = current_user
    @current_profile = current_profile
  end

  def template
    if @current_user.signed_in? && @current_profile.nil?
      article(class: "message is-warning") do
        div(class: "message-body") do
          text "You need to set up your profile to start posting. You can do that "
          a(href: "/profile") { "here" }
          text "."
        end
      end
    end
  end
end