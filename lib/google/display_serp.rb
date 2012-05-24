require 'formatador'
require 'htmlentities'

class Google
  def display_serp info
    results           = info[:results]
    query_strings     = info[:query_strings]
    coder             = HTMLEntities.new
    current_page      = results['responseData']['cursor']['currentPageIndex'] + 1
    max_result        = query_strings[:start] + query_strings[:rsz]
    estimated_results = results['responseData']['cursor']['resultCount']
    result_array      = results['responseData']['results']

    Formatador.display_line "[yellow]Powered by Google[/]"

    result_array.each_with_index do | result, i |
      this_num = (i + query_strings[:start] + 1).to_s

      if this_num.length < max_result.to_s.length
        serp_title = "\n#{' ' * (max_result.to_s.length - this_num.length)}[bold][blue]#{this_num}. "
      else
        serp_title  = "\n[bold][blue]#{this_num}. "
      end
      serp_title << "[normal]#{result["titleNoFormatting"]}[/]\n"
      serp_url    = ' ' * max_result.to_s.length
      serp_url   << "[green]#{result["url"]}[/]\n"
      serp_desc   = ' ' * max_result.to_s.length
      serp_desc  << result["content"].gsub(/<b>/, "[bold]").gsub(/<\/b>/, "[/]").squeeze(" ")

      Formatador.display_line coder.decode(Utils::wrap(serp_title, :prefix => max_result.to_s.length + 2))
      Formatador.display_line coder.decode(Utils::wrap(serp_url, :prefix => max_result.to_s.length + 2))
      Formatador.display_line coder.decode(Utils::wrap(serp_desc, :prefix => max_result.to_s.length + 2))
      Formatador.display_line "[/]"
    end

    metadata = ''
    metadata << "\n[yellow]Displaying results "
    metadata << "#{query_strings[:start] + 1} through "
    metadata << "#{max_result} of "
    metadata << "#{estimated_results} "
    metadata << "(Page #{current_page})"

    Formatador.display_line metadata
  end
end
