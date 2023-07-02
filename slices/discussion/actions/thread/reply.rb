# frozen_string_literal: true

class Discussion::Actions::Thread::Reply < Discussion::Action
  include Discussion::Deps[
    reply: "commands.add_message",
    repo: "repositories.thread",
    profile_repo: "repositories.profile",
    slugger: "utils.slugger",
    indexer: "utils.thread_indexer"
  ]

  def handle(req, res)
    thread = repo.get(slugger.decode_id(req.params[:id]))
    profile = profile_repo.get(res[:current_user].profile_id)
    message = reply.call(thread:, author: profile, content: req.params[:reply]).value!
    slug = slugger.to_slug(Discussion::Entities::Thread::HASHIDS_NUM, thread.title, thread.id)

    pager = repo.last_page(thread.id)

    res.redirect_to "/th/#{slug}?page=#{pager.current_page}##{indexer.(pager, message)}"
  end
end
