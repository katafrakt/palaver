# frozen_string_literal: true

class Discussion::Actions::Thread::Reply < Discussion::Action
  include Discussion::Deps[
    reply: "commands.add_message",
    repo: "repositories.thread",
    profile_repo: "repositories.profile",
    slugger: "utils.slugger"
  ]

  def handle(req, res)
    thread = repo.get(slugger.decode_id(req.params[:id]))
    profile = profile_repo.get(res[:current_user].profile_id)
    reply.call(thread:, author: profile, content: req.params[:reply])
    slug = slugger.to_slug(Discussion::Entities::Thread::HASHIDS_NUM, thread.title, thread.id)

    # TODO: redirect always to last page and add anchor
    res.redirect_to "/th/#{slug}"
  end
end
