#!/usr/bin/env sh
./filled_out_times.R
pdfcrop time-to-complete-questionnaire-in-hgi.pdf time-to-complete-questionnaire-in-hgi.pdf
mv time_to_complete_questionnaire_in_hgi.pdf ../../thesis/fblaauw_thesis/images/chapter3b/time-to-complete-questionnaire-in-hgi.pdf
