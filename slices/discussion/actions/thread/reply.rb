# frozen_string_literal: true

class Discussion::Actions::Thread::Reply < Discussion::Action
  include Discussion::Deps[
    "operations.reply_to_thread",
    repo: "repositories.thread",
    slugger: "utils.slugger"
  ]

  def handle(req, res)
    thread_id = slugger.decode_id(req.params[:id])
    thread = repo.get(thread_id)
    author = res[:current_user].to_author

    case reply_to_thread.call(thread:, author:, content: req.params[:reply])
    in Success(event)
      slug = slugger.to_slug(Discussion::Entities::Thread::HASHIDS_NUM, thread.title, thread.id)

      # TODO: redirect always to last page and add anchor
      res.redirect_to "/th/#{slug}"
    in Failure(:thread_locked)
      res.flash[:error] = "This thread is locked. You cannot reply to it."
      slug = slugger.to_slug(Discussion::Entities::Thread::HASHIDS_NUM, thread.title, thread.id)
      res.redirect_to "/th/#{slug}"
    else
      # TODO: figure out
    end
  end
end
