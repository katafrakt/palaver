# Palaver

This is my test application in Hanami 2. It attempts to replicate an experience of old-times discussion boards (think phpBB), while at the same time being a testing ground for standard features of a web app.

## Technical features

* Persistence – [ROM](https://rom-rb.org/)
* View layer – [Phlex](https://phlex.fun)
* User registration and authentication – custom-made, password hashing with Argon2, using native Hanami sessions
* Authorization – with [Verifica](https://github.com/maximgurin/verifica)
* Pagination – with [ROM pagination plugin](https://github.com/rom-rb/rom-sql/blob/main/lib/rom/sql/plugin/pagination.rb)
* File upload (for avatars) – [Shrine](https://shrinerb.com/) + [shrine-rom](https://github.com/shrinerb/shrine-rom)

## Contributing etc.

This is a personal testing projects. Currently I'm not accepting PRs, so please do not create them.
