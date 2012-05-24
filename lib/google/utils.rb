class Utils
  # From the trollop rubygem
  # File lib/trollop.rb, line 644
  def self.wrap_line str, opts={}
    prefix = opts[:prefix] || 0
    width = opts[:width] || (self.width - 1)
    start = 0
    ret = []
    until start > str.length
      nextt =
        if start + width >= str.length
          str.length
        else
          x = str.rindex(/\s/, start + width)
          x = str.index(/\s/, start) if x && x < start
          x || str.length
        end
      ret << (ret.empty? ? "" : " " * prefix) + str[start ... nextt]
      start = nextt + 1
    end
    ret
  end

  # From the trollop rubygem
  # File lib/trollop.rb, line 505
  def self.wrap str, opts={} # :nodoc:
    if str == ""
      [""]
    else
      str.split("\n").map { |s| self.wrap_line s, opts }.flatten(1).join("\n")
    end
  end

  # From the trollop rubygem
  # File lib/trollop.rb, line 489
  def self.width #:nodoc:
    @@width ||= if $stdout.tty?
      begin
        require 'curses'
        Curses::init_screen
        x = Curses::cols
        Curses::close_screen
        x
      rescue Exception
        80
      end
    else
      80
    end
  end
end
