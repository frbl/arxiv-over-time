#!/usr/bin/env sh
./user_stats.R
pdfcrop users-over-time.pdf users-over-time.pdf
mv users-over-time.pdf ../../thesis/fblaauw_thesis/images/chapter3b/users-over-time.pdf
mv users-over-time.tex ../../thesis/fblaauw_thesis/images/chapter3b/users-over-time.tex
