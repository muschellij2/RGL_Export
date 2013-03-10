savevtk <- function(array, filename){
#  savevtk Save a 3-D scalar array in VTK format.
#  savevtk(array, filename) saves a 3-D array of any size to
#  filename in VTK format.
    dd = dim(array)
    nx <- dd[1]
    ny <- dd[2]
    nz <- dd[3]
    fid = file(filename, 'wt');
    cat(file=fid, '# vtk DataFile Version 2.0\n');
    cat(file=fid, sprintf('Comment goes here\n'))
    cat(file=fid, sprintf('ASCII\n'))
    cat(file=fid, sprintf('\n'))
    cat(file=fid, sprintf('DATASET STRUCTURED_POINTS\n'))
    cat(file=fid, sprintf('DIMENSIONS    %d   %d   %d\n', nx, ny, nz))
    cat(file=fid, sprintf('\n'))
    cat(file=fid, sprintf('ORIGIN    0.000   0.000   0.000\n'))
    cat(file=fid, sprintf('SPACING    1.000   1.000   1.000\n'))
    cat(file=fid, sprintf('\n'))
    cat(file=fid, sprintf('POINT_DATA   %d\n', nx*ny*nz))
    cat(file=fid, sprintf('SCALARS scalars float\n'))
    cat(file=fid, sprintf('LOOKUP_TABLE default\n'))
    cat(file=fid, sprintf('\n'))
    for (a in 1:nx){
        for (b in 1:ny){
            for (c in 1:nz){
                cat(file=fid, sprintf('%d ', array(a,b,c)))
            }
            cat(file=fid, sprintf('\n'))
        }
    }
    close(fid);
}
