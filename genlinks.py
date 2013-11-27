import sys
import csv
from jinja2 import Environment, DictLoader
import argparse


script_version = 'v0.1.0'


class Link:
    def __init__(self, url, sitename):
        self.url = url
        self.sitename = sitename


templates = {'index.html': """<html>
  <body>
    <ul>
      {% for link in links %}
        <li><a href="{{ link.url }}">{{ link.sitename }}</a></li>
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
csvfile = open(filename, 'r')
reader = csv.reader(csvfile)
links = []
for row in reader:
    url = row[0]
    try:
        sitename = row[1]
    except IndexError:
        sitename = url
    links.append(Link(url, sitename))
csvfile.close

env = Environment(loader=DictLoader(templates))
tmpl = env.get_template('index.html')
html = tmpl.render(links=links)

print html

