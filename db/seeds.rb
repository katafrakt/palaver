require "faker"

categories = Discussion::Container["repositories.category"]
test = categories.create(name: "Test")
categories.create(name: "DevLog")

threads = Discussion::Container["repositories.thread"]
start_thread = Discussion::Container["commands.create_thread"]
reply_in_thread = Discussion::Container["commands.add_message"]
john = threads.create_profile("johnny")
martha = threads.create_profile("martha")
th1 = start_thread.call(title: "Topic 1", category_id: test.id, content: "test", author: john)
reply_in_thread.call(thread: th1, author: martha, content: "this is a longer reply to a previous message")
reply_in_thread.call(thread: th1, author: john, content: Faker::Lorem.paragraphs(number: 5).join(" "))
start_thread.call(title: "Topic 2", category_id: test.id, content: "test", author: john)
