# frozen_string_literal: true

Factory.define(:thread) do |f|
  f.title "test thread"
end

Factory.define(:profile) do |f|
  f.nickname "smithy"
end

Factory.define(:author, relation: :profiles) do |f|
  f.nickname "johndoe"
end

Factory.define(:last_message, relation: :messages) do |f|
  f.association(:author)
end

Factory.define(:latest_thread, relation: :threads) do |f|
  f.title "test"
end

Factory.define(:category) do |f|
  f.name "Announcements"
  f.association(:latest_thread)
end
