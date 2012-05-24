class Google
  def pipe command, url
    # puts "You want to pipe the data."
    # puts "URL: #{url}"
    # puts "Command: #{command}"
    text = grab(url)

    IO.popen(command, 'w+') do | process |
      process.write(text)
      process.close_write
      puts process.read
    end
  end

  def view url
    # puts "You want to view the data."
    # puts "URL: #{url}"
    Formatador.display Utils::wrap(grab(url))
  end
end
