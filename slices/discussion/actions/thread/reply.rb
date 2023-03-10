# frozen_string_literal: true

class Discussion::Actions::Thread::Reply < Discussion::Action
  include Discussion::Deps[
    reply: "commands.add_message",
    repo: "repositories.thread",
    profile_repo: "repositories.profile"
  ]

  def handle(req, res)
    thread = repo.get(req.params[:id])
    profile = profile_repo.get(res[:current_user].profile_id)
    reply.call(thread:, author: profile, content: req.params[:reply])

    # TODO: redirect always to last page and add anchor
    res.redirect_to "/th/#{thread.id}"
  end
end
