#! /usr/bin/env bash
rake erd filetype=dot notation=bachman
cat erd.dot | sed 's/concentrate = "true";/concentrate = "false";/' > erd.dot~
rm erd.dot
mv erd.dot~ erd.dot
dot -Tpdf erd.dot > erd.pdf
rm erd.dot
