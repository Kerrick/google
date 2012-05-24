require_relative 'google/trollop'
require_relative 'google/utils'
require_relative 'google/search'
require_relative 'google/request'
require_relative 'google/display_serp'

opts = Trollop::options do
  version "google v0.0.3 (c) 2012 Kerrick Long http://kerrick.github.com/google"
  banner <<-EOM
The google gem is a simple tool to search Gooogle with via a CLI.
Usage:
    google [options] "my search query string here"
where [options] are:
EOM

  opt :page,
      "Start by showing the <i>th result page.",
      :type => :int,
      :default => 1

  opt :size,
      "Show <i> results on each SERP. Must be between 1 and 8.",
      :type => :int,
      :default => 4

  opt :result,
      "Skip the SERP and show the <i>th result.",
      :type => :int

  opt :lucky,
      "I'm feeling lucky! Skip the SERP and show the first result. " +
      "(Alias to --result 1)"

  opt :version,
      "Print the version and exit."

  opt :help,
      "Show this information and exit."
end

query = ARGV.join(' ')
raise Trollop::die "no search query specified" if query.empty?

g = Google.new query, opts
g.search
