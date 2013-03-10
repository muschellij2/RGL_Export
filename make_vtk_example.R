rm(list=ls())
require(misc3d)
f <- function(x, y, z) x^2+y^2+z^2
x <- seq(-2,2,len=20)
ball <- contour3d(f,4,x,x,x, draw=FALSE)
drawScene.rgl(ball)
### get the triangles
allids <- rgl.ids()
id <- allids$id[allids$type == "triangles"]

filename="test.vtk"

 f <- file(filename, open = "w")
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
	close(f)