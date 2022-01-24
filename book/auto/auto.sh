#!/bin/bash

filename="pccb"
figfolder="./figure/"

rm -f ${filename}.txt ${filename}.pdf
python auto.py
platex -halt-on-error -interaction=nonstopmode -kanji=utf8 ${filename}.tex > ${filename}.txt 2>&1
dvipdfmx -q ${filename}.dvi >> ${filename}.txt 2>&1
rm -f ${filename}.aux ${filename}.dvi ${filename}.log ${filename}.tex ${filename}.txt
rm -rf ${figfolder}
