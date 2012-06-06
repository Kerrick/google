require 'google/utils'
require 'google/reverse-markdown/reverse_markdown'
require 'trollop'
require 'uri'
require 'open-uri'
require 'json'
require 'formatador'
require 'htmlentities'
require 'clipboard'

class Google
  def initialize(query, opts)
    @unescaped_query = query
    @query = URI.escape(query)
    @opts = opts
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
    results = JSON.parse(open(@api_url).read)
    if results['responseStatus'].to_i != 200
      Trollop::die Utils::wrap("Google Search API Status #{results['responseStatus']}. Details:\n"\
                               "#{results['responseDetails']}\nTry again in a moment")
    end

    {:results => results, :query_strings => query_strings}
  end

  def display_serp(info)
    results = info[:results]
    query_strings = info[:query_strings]
    coder = HTMLEntities.new
    current_page = results['responseData']['cursor']['currentPageIndex']+1
    max_result = query_strings[:start] + query_strings[:rsz]
    estimated_results = results['responseData']['cursor']['resultCount']
    result_array = results['responseData']['results']

    Formatador.display_line "\n#{' ' * (max_result.to_s.length + 2)}[yellow]Powered by Google[/]"

    result_array.each_with_index do |result, i|
      this_num = (i + query_strings[:start] + 1).to_s

      serp_title = "\n#{' ' * (max_result.to_s.length - this_num.length)}[bold][blue]#{this_num}. "\
                    "[normal]#{result["titleNoFormatting"]}[/]\n"
      serp_url = "#{' ' * max_result.to_s.length}[green]#{result["url"]}[/]\n"
      serp_desc = ' ' * max_result.to_s.length + result["content"].gsub(/<b>/, "[bold]").gsub(/<\/b>/, "[/]").squeeze(" ")

      Formatador.display_line coder.decode(Utils::wrap(serp_title, :prefix => max_result.to_s.length + 2))
      Formatador.display_line coder.decode(Utils::wrap(serp_url, :prefix => max_result.to_s.length + 2))
      Formatador.display_line coder.decode(Utils::wrap(serp_desc, :prefix => max_result.to_s.length + 2))
    end

    Formatador.display_line "\n#{' ' * (max_result.to_s.length + 2)}[yellow]Displaying results #{query_strings[:start] + 1}"\
                            " through #{max_result} of #{estimated_results} (Page #{current_page})"

    input info, result_array
  end

  def input(info, result_array)
    Formatador.display Utils::wrap("\n[yellow]Enter N or P for pagination, E or Q to quit, or a number to copy the url to your clipboard.")
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
        display_serp request(:q => @query, :rsz => @opts[:size], :start => info[:query_strings][:start] + @opts[:size])
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
          #puts str.inspect

          num = str[1].to_i - 1 # Remember, we are 1-indexing things for the user

          clipboard_copy url(result_array, info, num)
        end
      # Catch-all to grab input again
      else
        clipboard_copy url(result_array, info, 0)
    end
    exit
  end

  def clipboard_copy(plain_url, markdown_link_format = @opts[:markdown])
    text = if markdown_link_format
      "[#{@unescaped_query}](#{plain_url})"
    else
      plain_url
    end
    Clipboard.copy text
  end

  def url(result_array, info, obscure_num)
    result_array[obscure_num - info[:query_strings][:start]]['url']
  end


  def view(url)
    Formatador.display Utils::wrap(grab(url))
  end
end
