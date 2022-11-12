# frozen_string_literal: true

Factory.define(:topic) do |f|
  f.title "test topic"
end

Factory.define(:profile) do |f|
  f.nickname "smithy"
end

Factory.define(:author, relation: :profiles) do |f|
  f.nickname "johndoe"
end

Factory.define(:last_post, relation: :posts) do |f|
  f.association(:author)
end

Factory.define(:latest_topic, relation: :topics) do |f|
  f.title "test"
end

Factory.define(:category) do |f|
  f.name "Announcements"
  f.association(:latest_topic)
end
