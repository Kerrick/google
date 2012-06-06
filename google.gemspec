Gem::Specification.new do |s|
  s.name        = "google-copy-link"
  s.version     = "1.0.0"
  s.executables << 'goo'
  s.add_runtime_dependency "trollop", ["~> 1"]
  s.add_runtime_dependency "json", ["~> 1"]
  s.add_runtime_dependency "htmlentities", ["~> 4"]
  s.add_runtime_dependency "formatador", ["~> 0.2"]
  s.add_runtime_dependency "clipboard", ["~> 1.0.1"]

  s.add_development_dependency 'rspec',       '~> 2.5'
  s.add_development_dependency 'guard-rspec', '~> 0.2'

  s.date        = "2012-05-25"
  s.summary     = "Google Search on the command line"
  s.description = "A ruby gem to give you the power of Google Search in your command line and copy links to your clipboard"
  s.authors     = ["Jean-Michel Garnier" ,"Kerrick Long"]
  s.files       = ["bin/goo"]
  s.files      += ["lib/google.rb", "lib/google/utils.rb", "lib/google/reverse-markdown/reverse_markdown.rb"]
  s.files      += ["LICENSE.md", "README.md", "google.gemspec"]
  s.homepage    = "https://github.com/21croissants/google"
end
