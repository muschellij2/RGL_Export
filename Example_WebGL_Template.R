## Isosurfaces of a brain With WebGL
## Splitting function courtesy of Duncan Murdoch
## Open in Safari - make sure Developer -> Enable WebGL clicked
## Should also open in Chrome (Firefox has initialization problem)
## Can comment out datadir/outdir 
## Clear the workspace - rm(list=ls())


require(oro.nifti) # for reading
require(rgl) # for rendering
require(misc3d) # for contours
### writeWebGL_split - has add on for splitting triangles to maximum number of vertices
### use writeIt = FALSE for knitr - just splits up triangles
source('writeWebGL_split.R', chdir = FALSE)


### Template from MNI152 from FSL
template <- readNIfTI("MNI152_T1_2mm_brain.nii.gz", reorient=FALSE)


### threshold for brain image - just the overall brain
### make lower for smoother surface - 4500 has good mix of features
### 1000 is smooth
cut <- 4500

dtemp <- dim(template)
contour3d(template, x=1:dtemp[1], y=1:dtemp[2], z=1:dtemp[3], level = cut, alpha = 0.1, draw = TRUE)

### this would be the ``activation'' or surface you want to render 
### here just taking the upper WM from the template image
contour3d(template, level = c(8200, 8250), alpha = c(0.5, 0.8), add = TRUE, color=c("yellow", "red"))


text3d(x=dtemp[1]/2, y=dtemp[2]/2, z = dtemp[3]*0.98, text="Top")
text3d(x=dtemp[1]*0.98, y=dtemp[2]/2, z = dtemp[3]/2, text="Right")

### render this on a webpage!
browseURL(paste("file://", writeWebGL_split(dir=file.path(tempdir(), "webGL"),  template = "my_template.html", width=500), sep=""))

