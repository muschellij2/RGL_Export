brain_img <- "MNI152_T1_2mm_brain.nii.gz"
volnames <- c("Thresholded.nii.gz", "Thresholded.nii.gz")
visible <- c(TRUE, TRUE, FALSE)
campos <- c(120, 40, 120)
#make_xtk <- function(
template <- file("xtk_template.html")
res <- readLines(template, warn=FALSE)
title <- "XTK LESSON 11"
stylesheet <- 'http://lessons.goxtk.com/11/demo.css'
campos <- paste('[', campos[1], ", ", campos[2], ", ", campos[3], "]", sep="")
res <- gsub("%TITLE%", title, res)
res <- gsub("%STYLESHEET%", title, res)
res <- gsub("%CAMPOS%", title, res)

#)


