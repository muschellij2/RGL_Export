
Example_WebGL_Template.Rmd  - overall program that will take in MNI152_T1_2mm_brain.nii.gz, render a brain in RGL, threshold a brain - writes out WebGL all knitted up

my_template.html - same as rgl template but takes out the bottom lines of text

my_embed_template - same as my_template.html but takes out the <body> and <html> headers - MAY REQUIRE onload="webGLStart();" in the body of html document (or some other interactive functioning part to load webGL) - used for knitting - but may RStudio fails to render the md files pandoc and other converters will work though
MNI152_T1_2mm_brain.nii.gz - standard brain taken from FSL (www.fmrib.ox.ac.uk/fsl/)
