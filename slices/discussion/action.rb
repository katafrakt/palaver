class Discussion::Action < Palaver::Action
  before do |req, res|
    res[:current_profile] = nil
    if res[:current_user].signed_in?
      profile = Discussion::Container["repositories.profile"].from_current_user(res[:current_user])
      res[:current_profile] = profile
    end
  end

  # Redirects to root page if the user is not signed in
  def self.require_signed_in_user!
    before do |req, res|
      unless res[:current_user].signed_in?
        res.flash[:error] = "You need to be signed in to access this page"
        res.redirect_to "/"
        halt
      end
    end
  end
end
