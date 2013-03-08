writeWebGL_split <- function(ids=rgl.ids()$id, writeIt= TRUE, verb=TRUE, ...){
	if (!require(rgl)) install.packages("rgl")
	#if (!require(misc3d)) install.packages("misc3d")
	if (verb) print("Splitting Triangles")
	split_triangles <- function(ids = ids, maxsize=65535) {
	
		if (maxsize %% 3 != 0)
			stop("maxsize must be a multiple of 3")
	
		save <- par3d(skipRedraw=TRUE)
		on.exit(par3d(save))
	
		allids <- rgl.ids()
		ids <- with(allids, id[ id %in% ids & type == "triangles" ])
		for (id in ids) {
			count <- rgl.attrib.count(id, "vertices")
			if (count <= maxsize) next
			verts <- rgl.attrib(id, "vertices")
			norms <- rgl.attrib(id, "normals")
			cols <- rgl.attrib(id, "colors")
		
			rgl.pop(id=id)
			while (nrow(verts) > 0) {
				n <- min(nrow(verts), maxsize)
				triangles3d(verts[1:n,], normals=norms[1:n,], color=rgb(cols[1:n,1], cols[1:n,2], cols[1:n,3]), alpha=cols[1:n,4])
				verts <- verts[-(1:n),,drop=FALSE]
				norms <- norms[-(1:n),]
				cols <- cols[-(1:n),]
			}
		}
	}
	split_triangles(ids)
	if (writeIt) rgl:::writeWebGL(...)
}

