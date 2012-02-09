
class LinkGenerator

  def initialize(file)
    @links = File.readlines(file).map{|l| l.chomp}
  end

  def to_html
    str = ""
    str << "<html>\n"
    str << "  <body>\n"
    str << "    <ol>\n"
    @links.each do |url|
      str << "      <li><a href=\"#{url}\">#{url}</a></li>\n"
    end
    str << "    </ol>\n"
    str << "  </body>\n"
    str << "</html>\n"
    str
  end

end   # of class LinkGenerator


print LinkGenerator.new(ARGV.shift).to_html

