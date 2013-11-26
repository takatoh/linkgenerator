import sys
from jinja2 import Environment, DictLoader


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

