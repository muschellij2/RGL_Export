rm(list=ls())
f <- function(x, y, z) x^2+y^2+z^2
x <- seq(-2,2,len=20)
# ball <- contour3d(f,4,x,x,x, draw=FALSE)
# drawScene.rgl(ball)

template <- readNIfTI("MNI152_T1_2mm_brain.nii.gz", reorient=FALSE)
cut <- 1000

dtemp <- dim(template)
ball <- contour3d(template, x=1:dtemp[1], y=1:dtemp[2], z=1:dtemp[3], level = cut, alpha = 0.1, draw = FALSE)
drawScene.rgl(ball)
allids <- rgl.ids()
id <- allids$id[allids$type == "triangles"]

filename="test.vtk"


#rgl_to_vtk <- function(id, filename="test.vtk"){
  f <- file(filename, open = "w")
  on.exit(close(f))
  start <- c("# vtk DataFile Version 3.0", "3D Plot data", "ASCII")
  n3 <- rgl.attrib.count(id, "vertices")
  verts <- rgl.attrib(id, "vertices")
  norms <- rgl.attrib(id, "normals")
  cols <- rgl.attrib(id, "colors")

  if (n3 %% 3 != 0) stop("verts not divisible by 3")
  
  n <- n3/3
  start <- c(start, "DATASET POLYDATA", paste("POINTS ", n3, " float", sep=""))
  cat(start, sep="\n", file=f)
  dat <- matrix(t(verts), ncol=9, byrow=TRUE)
  cat(sprintf("%f %f %f %f %f %f %f %f %f\n", dat[,1], dat[,2], dat[,3],
              dat[,4], dat[,5], dat[,6], 
              dat[,7], dat[,8], dat[,9]), file = f, sep="")
  mat <- matrix(0:(n3-1), ncol = 3, byrow=TRUE)
  print(n)
  cat(sprintf("\nPOLYGONS %d %d\n", n, n3), file = f, sep="")
  cat(sprintf("3 %d %d %d\n", mat[,1], mat[, 2], mat[, 3]), file = f, sep="")

## -1 since 0 indexing system
#   l <- apply(verts, 1, function(xx)  which( rowSums(verts == xx) > 1)-1)
#   N <- sum(sapply(l, length))
#   cat(sprintf("\nTRIANGLE_STRIPS %d %d\n", n, N), file = f, sep="")
# 
#   for (irow in 1:nrow(verts)){
#       pts <- l[[irow]]
#       ll <- length(pts)
#       pts <- paste(pts, collapse= " ")
#       cat(sprintf("%d %s\n", ll, pts)  , file = f, sep="")
#   }
# 
# for (irow in 1:nrow(verts)){
#   l[[irow]] <- sort(c(irow-1, l[[irow]]))
# }

  # dat <- matrix(t(norms), ncol=9, byrow=TRUE)
# #   cat(sprintf("\nPOINT_DATA %d \nNORMALS Normals float \n", n3), file = f, sep="")
# #   cat(sprintf("%f %f %f %f %f %f %f %f %f\n", dat[,1], dat[,2], dat[,3],
# #               dat[,4], dat[,5], dat[,6], 
# #               dat[,7], dat[,8], dat[,9]), file = f, sep="")
# cat(sprintf("\nPOINT_DATA %d \nNORMALS Normals float \n", n), file = f, sep="")
# cat(sprintf("%f %f %f\n", dat[,1], dat[,2], dat[,3]
            # ), file = f, sep="")

  invisible(NULL)  




#}

