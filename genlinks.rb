posts = File.readlines(ARGV.shift).map{|l| l.chomp}

puts "<html>"
puts "  <body>"
puts "    <ol>"
posts.each do |url|
  puts "      <li><a href=\"#{url}\">#{url}</a></li>"
end
puts "    </ol>"
puts "  </body>"
puts "</html>"

