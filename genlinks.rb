#! ruby

require 'optparse'


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



opt = OptionParser.new
opt.banner = <<EOB
Usage: #{opt.program_name} [options] <file>
EOB
opt.on_tail('-h', '--help', 'Show this message.'){|v|
  print opt
  exit
}
opt.parse!


print LinkGenerator.new(ARGV.shift).to_html

