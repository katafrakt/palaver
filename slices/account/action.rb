# auto_register: false
# frozen_string_literal: true

module Account
  class Action < Palaver::Action
    include Deps[account_repo: "repositories.account"]

    before :fetch_current_user

    private

    def fetch_current_user(req, res)
      id = res[:_current_user_id]

      res[:current_user] = if id
        account_repo.by_session_id(id)
      end
    end
  end
end
