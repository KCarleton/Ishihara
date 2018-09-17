Ishihara_plot
===============
R code to print Ishihara patterns for behavioral color vision experiments.
## Introduction
This code was developed to produce visual targets for behavioral tests of color vision.  This is based on the work of Cheney et al (2018) "An Ishihara-style test of animal colour vision" Journal of Experimental Biology (in review) or see bioRxiv: https://www.biorxiv.org/content/early/2018/08/01/382051 ).  This code produces Ishihara patterns where one target spot differs from many background spots.  Multiple target spots are also possible. The Ishihara patterns are then used to test whether fish or other organisms can recognize the unique spot (the target) relative to the background spots.  The target differs in hue, while the background spots vary in luminance (being both greater and less in luminance from the target) but are similar to each other in hue.  This enables tests of color discrimination while controlling for luminance (letting it vary).  Cheney et al (2018) provide MatLab code to generate Ishihara patterns.  This R code was developed as a non-Matlab alternative. 

The Ishihara pattern is made up of circles or spots.  One or more target spots with unique hues are plotted first.  The background spots are randomly selected from a set of specified sizes and colors.  These background spots are divided into two groups: first_points which are selected to be larger and rest_points which can be any size and help fill in the space between the larger first_points.

## Key variables
* plotmaxx        set maximum x dimension of the plot
* plotmaxy        set maximum y dimension of the plot
* boundary_target set the width of a border around the edge so that the target spot occurs interior to that boundary

* number_points   the maximum number of spots to generate and try to fill in the pattern.  The larger this is the more full the spot pattern will be. Typically this is large, e.g 10,000
* first_points    the number of spots to plot first that are selected from the larger radii (set by min_size) compared to the complete set.  A number smaller than number_points, e.g. 500

* radius          the set of possible spot radii , e.g radius<-c(0.2, 0.3, 0.4, 0.5, 0.6)
* min_size        a number from 1 to # of radii which specifies the minimum radius for the spots in first_points.  So for example if min_size is 3, the first_points plotted spots will all have a radius greater or equal to the third value of radius i.e. 0.4 for the list above.

* offset_buffer   The circles are drawn with a border. Making the border white makes too much white space.  But having the borders be the same color as the spots can sometimes lead to small overlaps.  This variable builds in a bit more distance between spots to reduce that overlap.

* Target color(s). The target RGB value is specified as:
  - target_R<-0  
  - target_G<-0
  - target_B<-255
  
  If there are more colors listed for target colors, then the code makes more targets, e.g. the following makes three targets with one red, one green and one blue:
  - target_R<-c(0,0,255)
  - target_G<-c(0,255,0)
  - target_B<-c(255,0,0)
* The background spots are selected at random from a set of colors, where the first color would be R[1], G[1], B[1] etc.  These are ideally all the same distance from the target but differing in luminance.  The set below produces different shades of gray.
  - R<-c(50,75,100,125,150,175,200,225)   
  - G<-c(50,75,100,125,150,175,200,225)   
  - B<-c(50,75,100,125,150,175,200,225)
 
To generate a denser pattern, increase number_points. You can have as many background spot sizes and colors as you list 
in the radius or R,G,B arrays.

Here is an example of the output of Ishihara_plot:

![alt tag](https://github.com/KCarleton/Ishihara/blob/master/Ishihara_example.jpeg) 
