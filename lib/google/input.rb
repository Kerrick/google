require 'formatador'

class Google
  def input info, result_array
    prompt  = "\n[yellow]"
    prompt << "Enter N or P for Next or Previous page, E or Q to quit, "
    prompt << "or a number to see that result."

    Formatador.display Utils::wrap(prompt)

    Formatador.display "\n[bold]>[/] "
    choice = STDIN.gets.chomp + ' '

    case
    when choice[0].downcase == 'e' || choice[0].downcase == 'q'
      exit
    when choice[0].downcase == 'n'
      results = request :q => @query,
                        :rsz => @opts[:size],
                        :start => info[:query_strings][:start] + @opts[:size]
      display_serp results
    when choice[0].downcase == 'p'
      if info[:query_strings][:start] < 1
        Formatador.display Utils::wrap("[yellow]! Already at page one.")
        input info
      else
        results = request :q => @query,
                          :rsz => @opts[:size],
                          :start => info[:query_strings][:start] - @opts[:size]
        display_serp results
      end
    when choice[0].match(/\d/)
      /(\d+)(\s*\|(.*))*/.match(choice) do | str |
        num = str[1].to_i - 1
        if info[:query_strings][:start] <= num &&
           info[:query_strings][:start] + @opts[:size] > num
          if str[3].nil?
            view result_array[num - info[:query_strings][:start]]['url']
          else
            pipe str[3].strip,
                 result_array[num - info[:query_strings][:start]]['url']
          end
        else
          Formatador.display Utils::wrap("[yellow]! Result not on this page.")
          input info, result_array
        end
      end
    else
      input info
    end
  end
end
