# frozen_string_literal: true

require_relative "lib/hanami/dev_mail/version"

Gem::Specification.new do |spec|
  spec.name = "hanami-dev_mail"
  spec.version = Hanami::DevMail::VERSION
  spec.authors = ["Paweł Świątkowski"]
  spec.email = ["katafrakt@vivaldi.net"]

  spec.summary = "Development mail server for Hanami"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "hanami-mailer"
  spec.add_dependency "hanami-controller"
  spec.add_dependency "hanami-view"
  spec.add_dependency "pstore"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
