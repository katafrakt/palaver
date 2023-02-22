class Discussion::Action < Palaver::Action
  before do |req, res|
    res[:current_profile] = nil
    if res[:current_user].signed_in?
      profile = Discussion::Container["repositories.profile"].from_current_user(res[:current_user])
      res[:current_profile] = profile
    end
  end
end
