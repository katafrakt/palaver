categories = Discussion::Container['repositories.categories']
test = categories.create(name: 'Test')

topics = Discussion::Container['repositories.topics']
topics.create(title: "Topic 1", category_id: test.id)
topics.create(title: "Topic 2", category_id: test.id)