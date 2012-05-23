google
======

## A ruby gem to give you the power of Google Search in your command line.

The CLI displays results from the [Google Web Search API](https://developers.google.com/web-search/), allows you to page through the results, and choose a page to view, all without leaving the command line.

## Installation

    gem install google # Requires Ruby :)

## Usage Examples

Typing `google help` will list all the available commands. They are also listed here.

    USAGE:
      google [--lucky | -l] [--result=<num>] [--page=<num>] [--size=<num>] "Query"

    OPTIONS
        --lucky, -l
            Just show the contents of the first result. I'm feeling lucky!
            Synonym of --result=1

        --result=<num>
            Just show the contents of the <num>th result.

        --page=<num>
            Start by showing the <num>th page of results.
            Defaults to 1.

        --size=<num>
            Show <num> results on each page. Must be between 1 and 8.
            Defaults to 4.

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

## Screenshots

![SERP](https://github.com/Kerrick/google/raw/master/screenshots/serp.png)
![Readability](https://github.com/Kerrick/google/raw/master/screenshots/readability.png)

## History

This project is inspired by the [t gem](https://github.com/sferik/t), which provides a CLI for twitter.

## Contributing

In the spirit of [free software](http://www.gnu.org/philosophy/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways _you_ can contribute:

* By using the rolling [development branch](https://github.com/Kerrick/google/tree/develop).

* By [reporting bugs][issues]

* By [suggesting new features][issues]

* By writing or editing documentation

* By writing code (**no patch is too small**; fix typos, add comments, clean up inconsistent whitespace...)

* By refactoring code

* By fixing [issues][issues]

* By reviewing [patches][pulls]

[issues]: https://github.com/Kerrick/google/issues
[pulls]: https://github.com/Kerrick/google/pulls


## Submitting an Issue

We use the [GitHub issue tracker][issues] to track bugs and features. Before submitting a bug report or feature request, check to make sure it hasn't already been submitted. When submitting a bug report, please include any relevant output from the program and any details that may be necessary to reproduce the bug, including your gem version, Ruby version, and operating system.

## Submitting a Pull Request

0. [Fork the repository.][fork]
0. [Create a topic branch.][branch]
0. Implement your changes.
0. Test your changes heavily.
0. Add, commit, and push your changes.
0. [Submit a pull request.][pr]

[fork]: http://help.github.com/fork-a-repo/
[branch]: http://learn.github.com/p/branching.html
[pr]: http://help.github.com/send-pull-requests/

## Supported Ruby Versions

This library has only been tested against Ruby 1.9.3. Other versions might be supported, but they haven't been tested.

## Acknowledgements

This gem is [Powered by Google](http://www.google.com).

### Copyright

Copyright (c) 2012 Kerrick Long. See [LICENSE](https://github.com/Kerrick/google/blob/master/LICENSE.md) for details.

### Dependencies

* [Ruby Readability](https://github.com/iterationlabs/ruby-readability)

    * [Nokogiri](http://nokogiri.org/)

    * [guess_html_encoding](https://github.com/iterationlabs/guess_html_encoding)

* [JSON Implementation for Ruby](http://flori.github.com/json/)

* [Formatador](https://github.com/geemus/formatador)

* [HTML Entities for Ruby](http://htmlentities.rubyforge.org/)

* [Reverse Markdown](https://github.com/xijo/reverse_markdown)
