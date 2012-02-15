use strict;
use warnings;

use Text::CSV_XS;
use HTML::Template;
use Getopt::Long;


my $script_version = "v0.1.0";

sub usage {
    print "Usage: genlinks.pl [options] <file>\n";
    print "Options:\n";
    print "    --version         Show version.\n";
    print "    --help            Show this massage.\n";
}

my $opt_version = 0;
my $opt_help    = 0;
GetOptions('version' => \$opt_version, 'help' => \$opt_help);

if ($opt_help) {
  usage;
  exit;
} elsif ($opt_version) {
  print "$script_version\n";
  exit;
}


my $src =<<EOT;
<html>
  <body>
    <ol>
      <TMPL_LOOP NAME=LINKS>
      <li><a href="<TMPL_VAR NAME=URL>">
        <TMPL_IF NAME=NAME>
          <TMPL_VAR NAME=NAME>
        <TMPL_ELSE>
          <TMPL_VAR NAME=URL>
        </TMPL_IF>
      </a></li>
      </TMPL_LOOP>
    </ol>
  </body>
</html>
EOT

my $filename = shift @ARGV;
open(my $fh, '<', $filename) or die  "Cannot open file: $filename\n";

my @links;
my $tc = Text::CSV_XS->new;
while(<$fh>){
  next unless $tc->parse($_);
  my @fields = $tc->fields;
#  push(@links, { URL => $fields[0], NAME => $fields[1], BANNER => $fields[2]});
  push(@links, { URL => $fields[0], NAME => $fields[1]});
}

my $template = HTML::Template->new(scalarref => \$src);
$template->param(LINKS => \@links);
print $template->output;


