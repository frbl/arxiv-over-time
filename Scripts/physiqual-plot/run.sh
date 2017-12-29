#!/usr/bin/env sh
./histogram_image.R

plot=tophat_kernel_only_lines_original_data
pdfcrop $plot.pdf $plot.pdf
mv $plot.pdf ../../../thesis/fblaauw_thesis/images/chapter7/$plot.pdf
mv $plot.tex ../../../thesis/fblaauw_thesis/images/chapter7/$plot.tex

