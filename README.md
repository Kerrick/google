google-copy-link
================

The CLI displays results from the [Google Web Search API](https://developers.google.com/web-search/), allows you to page through the results, and choose a url to copy to your clipboard, all without leaving the command line.

[![Screenshot of `goo` in action!](https://github.com/21croissants/google/raw/master/screenshots/example_01.jpg)](https://github.com/21croissants/google/raw/master/screenshots/example_01.jpg "Click to view full size")

## Installation

    gem install google-copy-link # Requires Ruby 1.9

## Usage Examples

Typing `goo --help` will list all the available commands. They are also listed here.

    The goo gem is a simple tool to search Gooogle and copy a search result link to your clipboard.
    Usage:
        goo [options] "my search query string here"
    where [options] are:
          --markdown, -m:     Use markdown format when copying link to clipboard. Example: \[Trollop\]\(http://trollop.rubyforge.org/\) (Default: false)
            --page, -p <i>:   Start by showing the <i>th result page. (Default: 1)
            --size, -s <i>:   Show <i> results on each SERP. Must be between 1 and 8. (Default: 4)
          --result, -r <i>:   Skip the SERP and show the <i>th result.
                --help, -h:   Show this information and exit.

At the prompt, type the index of a search result, it will be copied to your clipboard.

If you press <Return>, the first search result link will be copied.

*ONLY TESTED with a mac*. Should work on linux and windows thanks to clipboard gem;)

When writing blog posts in Markdown or looking for libraries in google, I became tired to repeat the whole manual search process in the browser so I found a way to automate it;)

### Search on a single site

    goo 'site:randsinrepose.com NADD'

## Features

* You have access to all the [search operators](http://support.google.com/websearch/bin/answer.py?hl=en&answer=136861) you've come to know and love in Google Search.

* Results are shown in [markdown](http://daringfireball.net/projects/markdown/) for a good balance between legibility and document heirarchy. (Shoutout to [reverse_markdown](https://github.com/xijo/reverse_markdown)!)

* Results pages are formatted to look like a Google SERP, including colors, domains, descriptions, and bold search matches. (Shoutout to [formatador](https://github.com/geemus/formatador)!)

## Supported Ruby Versions

This library has only been tested against Ruby 1.9.3. Other versions might be supported, but they haven't been tested.

## Acknowledgements

Most of the code is a fork of Kerrick Long. See [LICENSE](https://github.com/21croissants/google/blob/master/LICENSE.md) for details.

This gem is [Powered by Google](http://www.google.com).

### Copyright

Copyright (c) 2012 Jean-Michel Garnier. See [LICENSE](https://github.com/21croissants/google/blob/master/LICENSE.md) for details.

### Dependencies

* [Trollop](http://trollop.rubyforge.org/) (gem)

* [JSON Implementation for Ruby](http://flori.github.com/json/) (gem)

* [Formatador](https://github.com/geemus/formatador) (gem)

* [HTML Entities for Ruby](http://htmlentities.rubyforge.org/) (gem)

* [Reverse Markdown](https://github.com/xijo/reverse_markdown) (lib)

* [clipboard gem](https://github.com/janlelis/clipboard)
