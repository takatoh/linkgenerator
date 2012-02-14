#! ruby

require 'csv'
require 'erb'
require 'optparse'


class LinkGenerator

  TEMPLATE = <<EOT
<html>
  <body>
    <ol>
      <%- @links.each do |link| -%>
      <li><a href="<%= link.url %>"><%= link.name || link.url %></a></li>
      <%- end -%>
    </ol>
  </body>
</html>
EOT


  def initialize(file)
    @links = File.readlines(file).map do |l|
      url, name, banner = l.parse_csv
      Link.new(url, name, banner)
    end
  end

  def to_html
    erb = ERB.new(TEMPLATE, nil, "-")
    erb.result(binding)
  end


  Link = Struct.new(:url, :name, :banner)


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

