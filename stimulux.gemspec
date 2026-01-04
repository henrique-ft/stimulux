# frozen_string_literal: true

require_relative 'lib/stimulux/version'

Gem::Specification.new do |spec|
  spec.name = 'stimulux'
  spec.version = Stimulux::VERSION
  spec.authors = ['henrique-ft']
  spec.email = ['hriqueft@gmail.com']

  spec.summary = "Stimulus, without brain gymnastics: helpers for 'data-' atributes generation in Phlex and HtmlSlice"
  spec.description = "Stimulus, without brain gymnastics: helpers for 'data-' atributes generation in Phlex and HtmlSlice"
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['source_code_uri'] = 'https://github.com/henrique-ft/stimulux'
  spec.metadata['changelog_uri'] = 'https://github.com/henrique-ft/stimulux/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  File.basename(__FILE__)
  spec.files =
    ['lib/stimulux.rb',
     'lib/stimulux/version.rb']

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
