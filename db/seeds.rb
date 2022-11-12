categories = Discussion::Container["repositories.categories"]
test = categories.create(name: "Test")
categories.create(name: "DevLog")

threads = Discussion::Container["repositories.threads"]
john = threads.create_profile("johnny")
threads.create(title: "Topic 1", category_id: test.id, content: "test", author_id: john.id)
threads.create(title: "Topic 2", category_id: test.id, content: "test", author_id: john.id)
