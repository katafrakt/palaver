# frozen_string_literal: true

class Discussion::Actions::Thread::Reply < Discussion::Action
  include Discussion::Deps[
    reply: "commands.add_message",
    repo: "repositories.thread",
    profile_repo: "repositories.profile"
  ]

  def handle(req, res)
    thread = repo.get(req.params[:id])
    user = profile_repo.from_current_user(res[:current_user])
    reply.call(thread:, author: user, content: req.params[:reply])

    # TODO: redirect always to last page and add anchor
    res.redirect_to "/th/#{thread.id}"
  end
end
