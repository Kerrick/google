require 'open-uri'
require 'ruby-readability'
require '../reverse-markdown/reverse_markdown'

class Google
  def grab url
    source = open(url).read

    if @opts[:readability]
      content = Readability::Document.new(source,
           :tags => %w[div p a pre code h1 h2 h3 h4 h5 h6 blockquote ul ol li],
           :attributes => %w[href],
           :remote_empty_nodes => true).content
    else
      content = source
    end

    if @opts[:markdown]
      output = ReverseMarkdown.new.parse_string(content)
    else
      output = content
    end

    output
  end
end
