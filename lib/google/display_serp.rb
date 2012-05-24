require 'formatador'
require 'htmlentities'

class Google
  def display_serp info
    results = info[:results]
    query_strings = info[:query_strings]
    coder = HTMLEntities.new
    current_page = results['responseData']['cursor']['currentPageIndex'] + 1
    estimated_results = results['responseData']['cursor']['resultCount']
    result_array = results['responseData']['results']

    Formatador.display_line "[yellow]Powered by Google[/]"

    result_array.each_with_index do | result, i |
      this_num = (i + query_strings[:start] + 1).to_s

      serp = ''
      serp << "\n[bold][blue][#{this_num}] "
      serp << "[normal]#{result["titleNoFormatting"]}[/]\n"
      serp << "[green]#{result["url"]}[/]\n"
      serp << result["content"].gsub(/<b>/, "[bold]").gsub(/<\/b>/, "[/]").squeeze(" ")

      Formatador.display coder.decode(Utils::wrap(serp))
      Formatador.display_line "[/]"
    end

    metadata = ''
    metadata << "\n[yellow]Displaying results "
    metadata << "#{query_strings[:start] + 1} through "
    metadata << "#{query_strings[:start] + query_strings[:rsz]} of "
    metadata << "#{estimated_results} "
    metadata << "(Page #{current_page})"

    Formatador.display_line metadata
  end
end
