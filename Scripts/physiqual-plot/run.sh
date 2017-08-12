#!/usr/bin/env sh
./histogram_image.R
pdfcrop tophat_kernel_only_lines_original_data.pdf tophat_kernel_only_lines_original_data.pdf
mv tophat_kernel_only_lines_original_data.pdf ../../../thesis/fblaauw_thesis/images/chapter7/tophat_kernel_only_lines_original_data.pdf
