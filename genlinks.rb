
class LinkGenerator

  def initialize(file)
    @links = File.readlines(file).map{|l| l.chomp}
  end

  def to_html
    puts "<html>"
    puts "  <body>"
    puts "    <ol>"
    @links.each do |url|
      puts "      <li><a href=\"#{url}\">#{url}</a></li>"
    end
    puts "    </ol>"
    puts "  </body>"
    puts "</html>"
  end

end   # of class LinkGenerator


file = ARGV.shift
LinkGenerator.new(file).to_html

