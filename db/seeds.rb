require "faker"

categories = Discussion::Container["repositories.category"]
test = categories.create(name: "Test")
categories.create(name: "DevLog")

threads = Discussion::Container["repositories.thread"]
john = threads.create_profile("johnny")
martha = threads.create_profile("martha")
th1 = threads.create(title: "Topic 1", category_id: test.id, content: "test", author: john)
threads.create_reply(thread: th1, author: martha, content: "this is a longer reply to a previous message")
threads.create_reply(thread: th1, author: john, content: Faker::Lorem.paragraphs(number: 5).join(" "))
threads.create(title: "Topic 2", category_id: test.id, content: "test", author: john)
