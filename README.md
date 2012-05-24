google
======

## The power of Google Search in your command line.

The CLI displays results from the [Google Web Search API](https://developers.google.com/web-search/), allows you to page through the results, and choose a page to view, all without leaving the command line.

[Hosted on RubyGems](https://rubygems.org/gems/google).

## Installation

    gem install google # Requires Ruby :)

## Usage Examples

Typing `google --help` will list all the available commands. They are also listed here.

    The google gem is a simple tool to search Gooogle with via a CLI.
    Usage:
        google [options] "my search query string here"
    where [options] are:
            --page, -p <i>:   Start by showing the <i>th result page. (Default: 1)
            --size, -s <i>:   Show <i> results on each SERP. Must be between 1 and 8. (Default: 4)
          --result, -r <i>:   Skip the SERP and show the <i>th result.
               --lucky, -l:   I'm feeling lucky! Skip the SERP and show the first result. (Alias to --result 1)
      --no-readability, -e:   Filter the results through readability to get rid of extra content. (Default: true)
         --no-markdown, -m:   Change the results from raw HTML to markdown. (Default: true)
             --version, -v:   Print the version and exit.
                --help, -h:   Show this information and exit.

### I'm Feeling Lucky into Less

    google -l 'how to install nvidia drivers debian squeeze' | less

### Search on a single site

    google 'site:randsinrepose.com NADD'

### Vanity Search

    google '"Kerrick Long" -inurl:kerrick -inurl:kerricklong'

## Features

* You have access to all the [search operators](http://support.google.com/websearch/bin/answer.py?hl=en&answer=136861) you've come to know and love in Google Search.

* If using the `--lucky` or `--result` flags, you can pipe the results into any other unix command.

* Results are filtered through [Readability](http://www.readability.com/), so you only get the relevant content. (Shoutout to [Ruby Readability](https://github.com/iterationlabs/ruby-readability)!)

* Results are shown in [markdown](http://daringfireball.net/projects/markdown/) for a good balance between legibility and document heirarchy. (Shoutout to [reverse_markdown](https://github.com/xijo/reverse_markdown)!)

* Results pages are formatted to look like a Google SERP, including colors, domains, descriptions, and bold search matches. (Shoutout to [formatador](https://github.com/geemus/formatador)!)

* You can pipe a result into another unix command! At the prompt, type the number of the result, followed by a pipe as normal. Note that utilities such as `less` and `more` that need to control the display don't work.

    > 3 | espeak -a 200 -v en-us

## Supported Ruby Versions

This library has only been tested against Ruby 1.9.3. Other versions might be supported, but they haven't been tested.

## Acknowledgements

This gem is [Powered by Google](http://www.google.com).

### Copyright

Copyright (c) 2012 Kerrick Long. See [LICENSE](https://github.com/Kerrick/google/blob/master/LICENSE.md) for details.

### Dependencies

* [Ruby Readability](https://github.com/iterationlabs/ruby-readability) (gem)

    * [Nokogiri](http://nokogiri.org/)

    * [guess_html_encoding](https://github.com/iterationlabs/guess_html_encoding)

* [JSON Implementation for Ruby](http://flori.github.com/json/) (gem)

* [Formatador](https://github.com/geemus/formatador) (gem)

* [HTML Entities for Ruby](http://htmlentities.rubyforge.org/) (gem)

* [Reverse Markdown](https://github.com/xijo/reverse_markdown) (lib)

* [Trollop](http://trollop.rubyforge.org/) (lib)
