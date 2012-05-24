require 'uri'

class Google

  def initialize query, opts
    @query = URI.escape(query)
    @opts = opts

    @opts[:size] = 8 if opts[:size] > 7
    @opts[:size] = 1 if opts[:size] <= 1
  end

  def search
    results = request :q => @query,
                      :rsz => @opts[:size],
                      :start => ((@opts[:page] - 1) * @opts[:size])
    display_serp results
  end
end
