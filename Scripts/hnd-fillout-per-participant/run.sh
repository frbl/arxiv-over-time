#!/usr/bin/env sh
./filled_out_times.R
./mssd-per-question.R
./distribution-of-adherance.R


plot=time-to-complete-questionnaire-in-hgi.pdf
pdfcrop $plot $plot
mv $plot ../../../thesis/fblaauw_thesis/images/chapter3b/$plot

plot=bimodal-distribution-in-adherance.pdf
pdfcrop $plot $plot
mv $plot ../../../thesis/fblaauw_thesis/images/chapter3b/$plot

plot=mssd-in-hgi.pdf
mv $plot ../../../thesis/fblaauw_thesis/images/appendix1/$plot

