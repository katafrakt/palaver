# frozen_string_literal: true

class Moderation::Repositories::Thread < Palaver::Repository[:threads]
  def get(id)
    threads.by_pk(id).one!
  end

  def pin(thread_id)
    threads.by_pk(thread_id).changeset(:update, pinned: true).commit
  end

  def unpin(thread_id)
    threads.by_pk(thread_id).changeset(:update, pinned: false).commit
  end
end
