Gem::Specification.new do |s|
  s.name = "google"
  s.version = "0.0.3"
  s.executables << 'google'
  s.add_runtime_dependency "json", ["~> 1.7"]
  s.add_runtime_dependency "htmlentities", ["~> 4.3"]
  s.add_runtime_dependency "formatador", ["~> 0.2"]
  s.date = "2012-05-23"
  s.summary = "Google Search on the command line"
  s.description = "A ruby gem to give you the power of Google Search in your command line."
  s.authors = ["Kerrick Long"]
  s.email = "me@kerricklong.com"
  s.files = ["lib/google.rb"]
  s.homepage = "http://kerrick.github.com/google/"
end
