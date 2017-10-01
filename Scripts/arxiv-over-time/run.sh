#!/usr/bin/env sh
./get_data.rb
./plot_data.r
pdfcrop ml-google-trends.pdf ml-google-trends.pdf
mv ml-google-trends.pdf ../../../thesis/fblaauw_thesis/images/chapter2/ml-google-trends.pdf
mv ml-google-trends.tex ../../../thesis/fblaauw_thesis/images/chapter2/ml-google-trends.tex
