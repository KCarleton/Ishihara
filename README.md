# Ishihara
R code to print Ishihara patterns for behavioral color vision experiments. 
This code was developed as a target for visual behavioral experiments based on the work of Karen Cheney, 
Justin Marshall, and John Endler.  It produces Ishihara patterns where one spot differs from many background 
spots.  These patterns are then used to test whether fish or other organisms can recognize the unique spot (the target) 
relative to the background spots.  The target is typically a different hue from the background spots.  The
background spots vary in luminance (being both greater and less in luminance from the target) but are similar in hue. 
This enables tests of color discrimination while controlling for luminance (letting it vary).  John Endler has written 
code in MatLab (see Cheney et al "An Ishihara-style test of animal colour vision" Methods in Ecology and Evolution).  
This version was written in R and is independent of John's Matlab code. Therefore, do not blame him for the foibles found here.

The pattern is made up of circles or spots.  The target spot is unique from the others in hue and is plotted first.  The 
background spots are randomly selected from a set of specified sizes and colors.  These background spots are 
divided into two groups: first_points which are selected to be larger and rest_points which can be any size and help fill 
in the space between the larger first_points.

There are several key variables to set up the patterns:
plotmaxx        set maximum x dimension of the plot
plotmaxy        set maximum y dimension of the plot
boundary_target set the width of a border around the edge so that the target spot occurs interior to that boundary

number_points   the maximum number of spots to generate and try to fill in the pattern.  The larger this is the more full the 
spot pattern will be. Typically this is large, e.g 10,000
first_points    the number of spots to plot first that are selected from the larger radii (set by min_size) compared 
to the complete set.  A number smaller than number_points, e.g. 500

radius          the set of possible circle radii , e.g c(0.2, 0.3, 0.4, 0.5, 0.6)
min_size        a number from 1 to # radii which sets the minimum radius for the first_points plotted circles.  So for 
example if min_size is 3, the first_points plotted will all have a radius greater or equal to the third value of radius
i.e. 0.4 for the list above

Spot colors. The target RGB value is specified as:
  target_R<-0  
  target_G<-0
  target_B<-255
The background spots are selected at random from a set of colors, where the first color would be R[1], G[1], B[1]
  R<-c(50,75,100,125,150,175,200,225)   
  G<-c(50,75,100,125,150,175,200,225)   
  B<-c(50,75,100,125,150,175,200,225)
 
To generate a denser pattern, increase number_points. You can have as many background spot sizes and colors as you list 
in the radius or R,G,B arrays.
