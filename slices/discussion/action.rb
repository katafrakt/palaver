# auto_register: false
# frozen_string_literal: true

class Discussion::Action < Palaver::Action
  include ::Discussion::Deps[profile_repo: "repositories.profile"]

  before :fetch_current_user

  private

  def fetch_current_user(req, res)
    id = res[:_current_user_id]

    res[:current_user] = if id
      profile_repo.current_user(id)
    else
      Discussion::Entities::CurrentUser.build_anonymous unless id
    end
  end
end
