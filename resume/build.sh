#!/bin/sh

~/dev/github/markdown-resume/bin/md2resume html --template swissen theodore.md .
mv theodore.html index.html
~/dev/github/markdown-resume/bin/md2resume pdf --template swissen theodore.md .
mv theodore.pdf theodorebaschak_resume.pdf
