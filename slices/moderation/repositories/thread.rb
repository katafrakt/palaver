# frozen_string_literal: true

class Moderation::Repositories::Thread < Palaver::DB::Repo[:threads]
  def get(id)
    threads.by_pk(id).one!.then do |record|
      Moderation::Entities::Thread.new(
        id: record.id,
        pinned: record.pinned,
        locked: record.locked
      )
    end
  end

  def handle(event)
    case event
    when Moderation::Events::ThreadPinned
      threads.by_pk(event.thread_id).changeset(:update, pinned: true).commit
      get(event.thread_id)
    when Moderation::Events::ThreadUnpinned
      threads.by_pk(event.thread_id).changeset(:update, pinned: false).commit
      get(event.thread_id)
    when Moderation::Events::ThreadLocked
      threads.by_pk(event.thread_id).changeset(:update, locked: true).commit
      get(event.thread_id)
    when Moderation::Events::ThreadUnlocked
      threads.by_pk(event.thread_id).changeset(:update, locked: false).commit
      get(event.thread_id)
    else
      raise NotImplementedError
    end
  end
end
