import sys
from jinja2 import Environment, DictLoader
import argparse


script_version = 'v0.0.1'

templates = {'index.html': """<html>
  <body>
    <ul>
      {% for url in urls %}
        <li><a href="{{ url }}">{{ url }}</a></li>
      {% endfor %}
    </ul>
  </body>
</html>
"""
}

parser = argparse.ArgumentParser(description='Generate links from URL list.')
parser.add_argument('file', metavar='FILE', nargs='?', action='store',
                     help='specify URL list file.')
parser.add_argument('-v', '--version', dest='version', action='store_true',
                     help='show version.')
args = parser.parse_args()

if args.version:
    print script_version
    sys.exit()

if len(sys.argv) == 1:
    print 'error: too few arguments. type genlinks.py --help.'
    sys.exit()

filename = sys.argv[1]
f = open(filename, 'r')
urls = []
for line in f:
    urls.append(line.rstrip('\n'))
f.close

env = Environment(loader=DictLoader(templates))
tmpl = env.get_template('index.html')
html = tmpl.render(urls=urls)

print html

