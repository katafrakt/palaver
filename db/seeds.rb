require "faker"

class Seeds
  def run
    test_cat = create_category("Test")
    create_category("Empty category")

    john = create_profile("johnny")
    martha = create_profile("Martha Ann van Smith")

    th1 = create_thread(test_cat, title: "Topic 1", content: "test", creator: john)
    reply_in_thread(th1, author: martha, content: "this is a longer reply to a previous message")
    reply_in_thread(th1, author: john, content: Faker::Lorem.paragraphs(number: 5).join(" "))

    create_thread(test_cat, title: "Topic 2", creator: john, content: "test")

    pinned = create_thread(test_cat, title: "Important announcement", content: "This is a pinned thread",
      creator: john)
    Moderation::Container["commands.pin_thread"].call(thread_id: pinned.id, moderator: john)

    th3 = create_thread(test_cat, title: "A long one", content: "Let's discus...", creator: martha)
    40.times do
      author = [john, martha].sample
      content = Faker::Lorem.sentence(word_count: rand(5..14))
      reply_in_thread(th3, author:, content:)
    end
  end

  private

  def create_category(name)
    repo = Discussion::Container["repositories.category"]
    record = repo.create(name:)
    Discussion::Entities::Category.from_rom(record)
  end

  def create_profile(name)
    repo = Discussion::Container["repositories.thread"]
    repo.create_profile(name)
  end

  def create_thread(category, args)
    repo = Discussion::Container["repositories.thread"]
    event = category.start_thread(**args)
    record = repo.handle_event(event)
    repo.get(record.id)
  end

  def reply_in_thread(thread, args)
    repo = Discussion::Container["repositories.thread"]
    event = thread.add_reply(**args)
    repo.handle_event(event)
  end
end

Seeds.new.run
