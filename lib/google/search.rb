require 'uri'

class Google

  def initialize query, opts
    @query = URI.escape(query)
    @opts = opts

    @opts[:size] = 8 if opts[:size] > 7
    @opts[:size] = 1 if opts[:size] <= 1
  end

  def search
    if @opts[:result]
      results = request :q => @query,
                        :rsz => 1,
                        :start => @opts[:result]
      view results[:results]['responseData']['results'][0]['url']
    else
      results = request :q => @query,
                        :rsz => @opts[:size],
                        :start => ((@opts[:page] - 1) * @opts[:size])
      display_serp results
    end
  end
end
