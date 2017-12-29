#!/usr/bin/env sh
./plot.R

plot=dsm-symptom-prevalence
pdfcrop $plot.pdf $plot.pdf
mv $plot.pdf ../../../thesis/fblaauw_thesis/images/chapter3b/$plot.pdf
mv $plot.tex ../../../thesis/fblaauw_thesis/images/chapter3b/$plot.tex

