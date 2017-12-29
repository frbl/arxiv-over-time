#!/usr/bin/env sh
./paper_sine_wave.R
./example_shocked.R


plot=pos_neg_area_discrete
pdfcrop $plot.pdf $plot.pdf
mv $plot.pdf ../../../thesis/fblaauw_thesis/images/chapter4/$plot.pdf
mv $plot.tex ../../../thesis/fblaauw_thesis/images/chapter4/$plot.tex

plot=example_response_aira
pdfcrop $plot.pdf $plot.pdf
mv $plot.pdf ../../../thesis/fblaauw_thesis/images/chapter4/$plot.pdf
mv $plot.tex ../../../thesis/fblaauw_thesis/images/chapter4/$plot.tex
