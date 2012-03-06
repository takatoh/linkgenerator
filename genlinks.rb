#! ruby

require 'csv'
require 'erb'
require 'optparse'


SCRIPT_VERSION = "v0.1.0"

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

  def to_html(template_file = nil)
    if template_file
      template = File.read(template_file)
    else
      template = TEMPLATE
    end
    erb = ERB.new(template, nil, "-")
    erb.result(binding)
  end


  Link = Struct.new(:url, :name, :banner)


end   # of class LinkGenerator



options = {}
opt = OptionParser.new
opt.banner = <<EOB
Usage: #{opt.program_name} [options] <file>
EOB
opt.on('-t', '--template=FILE', 'Use FILE as template.'){|v|
  options[:template] = v
}
opt.on_tail('-v', '--version', 'Show version.'){|v|
  print SCRIPT_VERSION + "\n"
  exit
}
opt.on_tail('-h', '--help', 'Show this message.'){|v|
  print opt
  exit
}
opt.parse!


print LinkGenerator.new(ARGV.shift).to_html(options[:template])

