require 'google/utils'
require 'google/reverse-markdown/reverse_markdown'
require 'trollop'
require 'uri'
require 'open-uri'
require 'json'
require 'formatador'
require 'htmlentities'
require 'ruby-readability'

class Google
  def initialize(query, opts)
    @query       = URI.escape(query)
    @opts        = opts
    @opts[:size] = 8 if opts[:size] > 7
    @opts[:size] = 1 if opts[:size] <= 1
  end

  def search
    if @opts[:result]
      results = request :q => @query, :rsz => 1, :start => (@opts[:result] - 1)
      view results[:results]['responseData']['results'][0]['url']
    else
      results = request :q => @query, :rsz => @opts[:size], :start => ((@opts[:page] - 1) * @opts[:size])
      display_serp results
    end
  end

  def request(query_strings)
    @api_url = "http://ajax.googleapis.com/ajax/services/search/web?v=1.0"\
               "&rsz=#{query_strings[:rsz]}&start=#{query_strings[:start]}&q=#{query_strings[:q]}"
    results  = JSON.parse(open(@api_url).read)
    if results['responseStatus'].to_i != 200
      Trollop::die Utils::wrap("Google Search API Status #{results['responseStatus']}. Details:\n"\
                               "#{results['responseDetails']}\nTry again in a moment")
    end

    {:results => results, :query_strings => query_strings}
  end

  def display_serp(info)
    results           = info[:results]
    query_strings     = info[:query_strings]
    coder             = HTMLEntities.new
    current_page      = results['responseData']['cursor']['currentPageIndex']+1
    max_result        = query_strings[:start] + query_strings[:rsz]
    estimated_results = results['responseData']['cursor']['resultCount']
    result_array      = results['responseData']['results']

    Formatador.display_line "\n#{' ' * (max_result.to_s.length + 2)}[yellow]Powered by Google[/]"

    result_array.each_with_index do |result, i|
      this_num = (i + query_strings[:start] + 1).to_s

      serp_title  = "\n#{' ' * (max_result.to_s.length - this_num.length)}[bold][blue]#{this_num}. "\
                    "[normal]#{result["titleNoFormatting"]}[/]\n"
      serp_url    = "#{' ' * max_result.to_s.length}[green]#{result["url"]}[/]\n"
      serp_desc   = ' ' * max_result.to_s.length + result["content"].gsub(/<b>/, "[bold]").gsub(/<\/b>/, "[/]").squeeze(" ")

      Formatador.display_line coder.decode(Utils::wrap(serp_title, :prefix => max_result.to_s.length + 2))
      Formatador.display_line coder.decode(Utils::wrap(serp_url, :prefix => max_result.to_s.length + 2))
      Formatador.display_line coder.decode(Utils::wrap(serp_desc, :prefix => max_result.to_s.length + 2))
    end

    Formatador.display_line "\n#{' ' * (max_result.to_s.length + 2)}[yellow]Displaying results #{query_strings[:start] + 1}"\
                            " through #{max_result} of #{estimated_results} (Page #{current_page})"

    input info, result_array
  end

  def input(info, result_array)
    Formatador.display Utils::wrap("\n[yellow]Enter N or P for pagination, E or Q to quit, or a number to see that result.")
    Formatador.display "\n[bold]>[/] "
    choice = STDIN.gets
    if choice.nil? # Likely because the user submitted EOT via ^D
      choice = ' '
    else
      choice.chomp + ' '
    end

    case
    # Quit
    when choice[0].downcase == 'e' || choice[0].downcase == 'q'
      exit
    # Next Page
    when choice[0].downcase == 'n'
      display_serp  request(:q => @query, :rsz => @opts[:size], :start => info[:query_strings][:start] + @opts[:size])
    # Previous Page
    when choice[0].downcase == 'p'
      if info[:query_strings][:start] < 1
        Formatador.display Utils::wrap("[yellow]! Already at page one.")
        input info, result_array
      else
        display_serp request(:q => @query, :rsz => @opts[:size], :start => info[:query_strings][:start] - @opts[:size])
      end
    # Numerical Choice
    when choice[0].match(/\d/)
      /(\d+)(\s*\|(.*))*/.match(choice) do |str|
        num = str[1].to_i - 1 # Remember, we are 1-indexing things for the user
        # Is the result on the current page?
        if info[:query_strings][:start] <= num && info[:query_strings][:start] + @opts[:size] > num
          # Is the user piping the result to something?
          if str[3].nil?
            view result_array[num - info[:query_strings][:start]]['url']
          else
            pipe str[3].strip, result_array[num - info[:query_strings][:start]]['url']
          end
        else
          Formatador.display Utils::wrap("[yellow]! Result not on this page.")
          input info, result_array
        end
      end
    # Catch-all to grab input again
    else
      input info, result_array
    end
  end

  def grab(url)
    source = open(url).read
    content = @opts[:readability] ? Readability::Document.new(source,
                                                              :tags => %w[div p a pre code h1 h2 h3 h4 h5 h6 blockquote ul ol li],
                                                              :attributes => %w[href],
                                                              :remote_empty_nodes => true).content : source
    output = @opts[:markdown] ? ReverseMarkdown.new.parse_string(content) : content
    output
  end

  def pipe(command, url)
    text = grab(url)
    IO.popen(command, 'w+') do |process|
      process.write(text)
      process.close_write
      puts process.read
    end
  end

  def view(url)
    Formatador.display Utils::wrap(grab(url))
  end
end
