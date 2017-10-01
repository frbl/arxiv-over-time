#!/usr/bin/env sh
./filled_out_times.R
./mssd-per-question.R
./distribution-of-adherance.R


plot=time-to-complete-questionnaire-in-hgi
pdfcrop $plot.pdf $plot.pdf
mv $plot.pdf ../../../thesis/fblaauw_thesis/images/chapter3b/$plot.pdf
mv $plot.tex ../../../thesis/fblaauw_thesis/images/chapter3b/$plot.tex

plot=bimodal-distribution-in-adherance
pdfcrop $plot.pdf $plot.pdf
mv $plot.pdf ../../../thesis/fblaauw_thesis/images/chapter3b/$plot.pdf
mv $plot.tex ../../../thesis/fblaauw_thesis/images/chapter3b/$plot.tex

plot=mssd-in-hgi
mv $plot.pdf ../../../thesis/fblaauw_thesis/images/chapter3b/$plot.pdf
mv $plot.tex ../../../thesis/fblaauw_thesis/images/chapter3b/$plot.tex
