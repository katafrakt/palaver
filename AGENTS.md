# Palaver - Agent Guidelines

## Commands
- **Test all**: `bundle exec rspec`
- **Test single file**: `bundle exec rspec spec/path/to/file_spec.rb`
- **Lint**: `bundle exec standardrb`
- **Migrate DB**: `bundle exec hanami db migrate`
- **Compile assets**: `bundle exec hanami assets compile`
- **Seed DB**: `bundle exec rake db:seeds`

## Code Style
- **Framework**: Hanami 2, ROM persistence, Phlex views
- **Linting**: StandardRB (default config)
- **Testing**: RSpec with request specs
- **Error handling**: Dry::Monads[:result]
- **Naming**: PascalCase modules/classes, snake_case methods
- **Frozen strings**: Always use `# frozen_string_literal: true`
- **Imports**: Require dependencies at top, use Hanami auto-injection
- **Types**: Use dry-types for validation
- **Views**: Phlex components with `view_template` method
- **Security**: Argon2 password hashing, Hanami sessions
