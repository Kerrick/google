require_relative 'trollop/lib/trollop'
require_relative 'google/utils'
require_relative 'google/search'
require_relative 'google/request'
require_relative 'google/display_serp'
require_relative 'google/input'
require_relative 'google/grab'
require_relative 'google/pipe-view'

opts = Trollop::options do
  version "google v1.0.7 (c) 2012 Kerrick Long http://kerrick.github.com/google"
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

  opt :readability,
      "Filter the results through readability to get rid of extra content.",
      :default => true

  opt :markdown,
      "Change the results from raw HTML to markdown.",
      :default => true

  opt :version,
      "Print the version and exit."

  opt :help,
      "Show this information and exit."
end

query = ARGV.join(' ')
raise Trollop::die "no search query specified" if query.empty?

opts[:result] = 1 if opts[:lucky]
if !opts[:readability] && opts[:markdown]
  raise Trollop::die "Must use --no-markdown if you use --no-readability"
end

begin
  g = Google.new query, opts
  g.search
rescue Interrupt
  puts "\nInterrupt received. Exiting application."
  exit
end
