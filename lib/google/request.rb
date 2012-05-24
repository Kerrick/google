require 'open-uri'
require 'json'

class Google
  def request query_strings
    @api_url = "http://ajax.googleapis.com/ajax/services/search/web?v=1.0"
    @api_url << "&rsz=#{query_strings[:rsz]}"
    @api_url << "&start=#{query_strings[:start]}"
    @api_url << "&q=#{query_strings[:q]}"

    results = JSON.parse(open(@api_url).read)

    if results['responseStatus'].to_i != 200
      Trollop::die Utils::wrap("Google Search API Status " +
                   "#{results['responseStatus']}. Details:\n" +
                   "#{results['responseDetails']}\nTry again in a moment")
    end
    {results: results, query_strings: query_strings}
  end
end
