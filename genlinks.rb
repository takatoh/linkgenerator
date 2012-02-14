#! ruby

require 'erb'
require 'optparse'


class LinkGenerator

  TEMPLATE = <<EOT
<html>
  <body>
    <ol>
<% @links.each do |url| -%>
      <li><a href="<%= url %>"><%= url %></a></li>
<% end -%>
    </ol>
  </body>
</html>
EOT


  def initialize(file)
    @links = File.readlines(file).map{|l| l.chomp}
  end

  def to_html
    erb = ERB.new(TEMPLATE, nil, "-")
    erb.result(binding)
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

