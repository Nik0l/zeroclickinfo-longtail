#!/bin/bash

base="data/congress"

echo '<add allowDups="true">' > output.xml

for f in $(find $base -name data.json); do
  ./parse.pl "$f" >> output.xml
done

echo '</add>' >> output.xml
