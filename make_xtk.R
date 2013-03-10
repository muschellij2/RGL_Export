volnames <- c("MNI152_T1_2mm_brain.nii.gz", "Thresholded.nii.gz", "Thresholded.nii.gz", "Thresholded.nii.gz")
visible <- c(TRUE, TRUE, FALSE, FALSE)
campos <- c(120, 40, 120)
min.color <- c('white', "red", "blue", "green")
max.color <- c('white', "red", "blue", "green")
alpha <- c(0.2, rep(1, length(volnames)-1))
threshold <- matrix(c(4500, 4800, rep(c(1,1), length(volnames)-1)), ncol=2, byrow=TRUE)
gui <- TRUE

make_xtk <- function(volnames, fname = "R_xtk_output.html", threshold, visible, min.color, 
                     max.color=NULL, alpha, campos = c(120, 40, 120), gui=TRUE){

if (is.null(max.color)) max.color <- min.color
#if (length(color) == 1) color <- rep(color, length(allvols))
if (length(alpha) == 1) color <- rep(alpha, length(allvols))
if (NROW(min.color)!=length(volnames)) stop("Colors not correct")
if (NROW(max.color)!=length(volnames)) stop("Colors not correct")
if (length(visible)!=length(volnames)) stop("Visible not correct")
if (length(alpha)!=length(volnames)) stop("Alpha not correct")
if (length(campos)!=3) stop("Camera position needs to be of length 3")

template <- file("xtk_template.html")
res <- readLines(template, warn=FALSE)
close(template)
title <- "XTK LESSON 11"
stylesheet <- 'http://lessons.goxtk.com/11/demo.css'
campos <- paste('[', campos[1], ", ", campos[2], ", ", campos[3], "]", sep="")
res <- gsub("%TITLE%", title, res)
res <- gsub("%STYLESHEET%", stylesheet, res)
res <- gsub("%CAMPOS%", campos, res)

visible <- tolower(as.character(visible))

vols <- NULL
for (ivol in 1:length(volnames)){
	vols <- c(vols, sprintf("  var volume%d = new X.volume();", ivol), 
		sprintf("  volume%d.file = '%s';", ivol, volnames[ivol]),
	  sprintf("  r.add(volume%d);", ivol)
    )
}

pos <- grep("%ADDVOLUMES%", res)
res <- c(res[1:(pos-1)], vols, res[(pos+1):length(res)])

if (class(min.color) != "matrix") min.color <- t(col2rgb(min.color))
if (class(max.color) != "matrix") max.color <- t(col2rgb(max.color))


vols <- NULL
for (ivol in 1:length(volnames)){
  vols <- c(vols, "", 
            sprintf("  volume%d.volumeRendering = true;", ivol), 
            sprintf("  volume%d.visible = %s;", ivol, visible[ivol]),
            sprintf("  volume%d.minColor = [%d, %d, %d];", ivol, min.color[ivol,1], min.color[ivol,2], min.color[ivol,3]), 
            sprintf("  volume%d.maxColor = [%d, %d, %d];", ivol, max.color[ivol,1], max.color[ivol,2], max.color[ivol,3]), 
            sprintf("  volume%d.opacity = %02.2f;", ivol, alpha[ivol]), 
            sprintf("  volume%d.lowerThreshold = %d;", ivol, threshold[ivol,1]), 
            sprintf("  volume%d.upperThreshold = %d;", ivol, threshold[ivol,2])
  )
}

if (gui){
  vols <- c(vols, "var gui = new dat.GUI();")

  for (ivol in 1:length(volnames)){
    vols <- c(vols, "", 
                sprintf("  var volumegui%d = gui.addFolder('volume%d');", ivol, ivol),
                sprintf("  var vMapVisibleController%d = volumegui%d.add(volume%d, 'visible');", ivol, ivol, ivol),
                sprintf("  var opacityController%d = volumegui%d.add(volume%d, 'opacity', 0, 1).listen();", ivol, ivol, ivol), 
                sprintf("  var lowerThresholdController%d = volumegui%d.add(volume%d, 'lowerThreshold', volume%d.min, volume%d.max);", ivol, ivol, ivol, ivol, ivol), 
                sprintf("  var upperThresholdController%d = volumegui%d.add(volume%d, 'lowerThreshold', volume%d.min, volume%d.max);", ivol, ivol, ivol, ivol, ivol), 
                sprintf("  volumegui%d.open();", ivol)
    )
  }  
  
}

pos <- grep("%SHOWTIME%", res)
res <- c(res[1:(pos-1)], vols, res[(pos+1):length(res)])

f <- file(fname)
writeLines(res, con=f)
close(f)


}


