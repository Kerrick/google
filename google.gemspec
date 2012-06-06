Gem::Specification.new do |s|
  s.name        = "google"
  s.version     = "1.0.10"
  s.executables << 'google'
  s.add_runtime_dependency "trollop", ["~> 1"]
  s.add_runtime_dependency "json", ["~> 1"]
  s.add_runtime_dependency "htmlentities", ["~> 4"]
  s.add_runtime_dependency "formatador", ["~> 0.2"]
  s.add_runtime_dependency "ruby-readability", ["~> 0.5"]

  s.add_development_dependency 'rspec',       '~> 2.5'
  s.add_development_dependency 'guard-rspec', '~> 0.2'

  s.date        = "2012-05-25"
  s.summary     = "Google Search on the command line"
  s.description = "A ruby gem to give you the power of Google Search in your command line."
  s.authors     = ["Kerrick Long"]
  s.email       = "me@kerricklong.com"
  s.files       = ["bin/google"]
  s.files      += ["lib/google.rb", "lib/google/utils.rb", "lib/google/reverse-markdown/reverse_markdown.rb"]
  s.files      += ["LICENSE.md", "README.md", "google.gemspec"]
  s.homepage    = "http://kerrick.github.com/google/"
end
