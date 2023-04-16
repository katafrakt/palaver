require "faker"

categories = Discussion::Container["repositories.category"]
test = categories.create(name: "Test")
categories.create(name: "DevLog")

threads = Discussion::Container["repositories.thread"]
start_thread = Discussion::Container["commands.create_thread"]
reply_in_thread = Discussion::Container["commands.add_message"]

john = threads.create_profile("johnny")
martha = threads.create_profile("martha")

th1 = start_thread.call(title: "Topic 1", category_id: test.id, content: "test", author: john).value!
reply_in_thread.call(thread: th1, author: martha, content: "this is a longer reply to a previous message")
reply_in_thread.call(thread: th1, author: john, content: Faker::Lorem.paragraphs(number: 5).join(" "))
start_thread.call(title: "Topic 2", category_id: test.id, content: "test", author: john)
start_thread.call(title: "Important announcement", category_id: test.id, content: "This is pinned thread",
  author: john).fmap do |pinned|
  Moderation::Container["commands.pin_thread"].call(thread_id: pinned.id, moderator: john)
end

th3 = start_thread.call(title: "A long one", category_id: test.id, content: "Let's discus...", author: john).value!
40.times do
  author = [john, martha].sample
  content = Faker::Lorem.sentence(word_count: rand(5..14))
  reply_in_thread.call(thread: th3, author:, content:)
end
