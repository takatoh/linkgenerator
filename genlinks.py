#!/usr/bin/env python
# coding utf-8

import sys
import csv
from jinja2 import Environment, DictLoader
import codecs
import argparse


script_version = 'v0.1.0'


class Link:
    def __init__(self, url, sitename):
        self.url = url
        self.sitename = sitename


templates = {'index.html': """<html>
  <body>
    <ul>
      {% for link in links -%}
        <li><a href="{{ link.url }}">{{ link.sitename }}</a></li>
      {% endfor -%}
    </ul>
  </body>
</html>
"""
}


def unicode_csv_reader(unicode_csv_data, dialect=csv.excel, **kwargs):
    csv_reader = csv.reader(utf_8_encoder(unicode_csv_data),
                            dialect=dialect, **kwargs)
    for row in csv_reader:
        yield [unicode(cell, 'utf-8') for cell in row]

def utf_8_encoder(unicode_csv_data):
    for line in unicode_csv_data:
        yield line.encode('utf-8')


parser = argparse.ArgumentParser(description='Generate links from URL list.')
parser.add_argument('file', metavar='FILE', nargs=1, action='store',
                     help='specify URL list file.')
parser.add_argument('-t', '--template', dest='template', metavar='TEMPLATE', action='store',
                     help='specify template.')
parser.add_argument('-v', '--version', action='version', version=script_version,
                     help='show version.')
args = parser.parse_args()

if args.template:
    f = open(args.template, 'r')
    templates['index.html'] = f.read()
    f.close()

filename = args.file[0]
csvfile = codecs.open(filename, 'r', 'utf-8')
reader = unicode_csv_reader(csvfile)
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

print html.encode('utf-8')
