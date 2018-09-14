###############################################################
#
#      Drawing Ishihara stimuli
#
###############################################################
# Karen Carleton Sept 14, 2018
# This program will draw Ishihara plots consisting of circles of different
# size and hue that are randomly placed on a background.  The first one or more points
# are the target spots and are different hues from the rest.  The targets are surrounded by
# background points that vary in luminance but which are all similar in hue.  The size, 
#position, and background color of each spot is determined by a random number generator.  
#As each point tries to be added, the program checks whether it will overlap with spots 
#that have already been placed.  
#
library(plotrix)
##############################################################
# Variables to enter
# Plot dimensions and size of edge boundary to keep targets towards the center
  plot_maxx<-25  #  max x dimension for plot
  plot_maxy<-20 #  max y dimension for plot 
  boundary_target<-5  # keeps target away from the edge
# max number of points to try - how long to run program to try to fill in white space
  number_points<-15000
# first_points is the number of bigger points to plot before adding the smaller ones to fill in
# SET this to determine how many points to be plotted in this first set which will be selected
# from the larger radius sizes Note: this includes size of very first point which is the unique target 
  first_points<-500
# range of possible spot radii
  radius<-c(0.2,0.3,0.35,0.4,0.45,0.5)  
  # Set minimum radius size for the set of first_points 
# if radii are 0.2, 0.3, 0.4 and 0.5 and if set this to 3 (the third one) then min radius is 0.4 
  min_size<-3   
# When it draws the circles it draws them with a border.  The border thickness sometimes makes
# the circles overlap.  This overlap_buffer builds in a bit more space between the circles.
  overlap_buffer<-0.02
# Target color(s) 
# The number of target colors determines the number of target spots. This (these) spot(s) 
# has (have) a unique color compared to the background spots. If there is just one value 
#  for R, G and B there will be one target.  More colors will produce more targets
  target_R<-c(0)  
  target_G<-c(0)
  target_B<-c(255)
#set background spots colors
  R<-c(50,75,100,125,150,175,200,225)   # this is where you set different possible background colors in RGB
  G<-c(50,75,100,125,150,175,200,225)   # the color for point 1 is R[1],G[1],B[1] etc
  B<-c(50,75,100,125,150,175,200,225)
# 
  ##########################################################
#
# Calculate some things
  number_radii<-length(radius)+1  #number of radii +1
  number_colors<-length(R)+1   #number of colors + 1
  rest_points<-number_points - first_points
# set up target colors
  number_targets<-length(target_R)  #number of targets
  target_color=matrix(nrow = number_targets)
  for (i in 1:number_targets) {
    target_r<-target_R[i]/255  # convert target RGB to plottable color
    target_g<-target_G[i]/255
    target_b<-target_B[i]/255
    target_color[i]<-rgb(target_r,target_g,target_b)
  }
#  
#define matrices
  current_radius<-matrix(nrow=number_points)   
  current_R<-matrix(nrow=number_points)
  current_G<-matrix(nrow=number_points)
  current_B<-matrix(nrow=number_points)
  current_color<-matrix(nrow=number_points)
  criteria<-matrix(nrow=number_points, ncol=number_points)
  test_overlap<-matrix(nrow=number_points)
  xhold<-matrix(nrow=number_points)
  yhold<-matrix(nrow=number_points)
  radhold<-matrix(nrow=number_points)
#random number generators for point positions
  x<-runif(number_points,0,plot_maxx)
  y<-runif(number_points,0,plot_maxy)
# recalc position of target(s) so it is (they are) away from edge based on value of boundary_target
  for (i in 1:number_targets) {
    x[i]<-runif(1,boundary_target, plot_maxx-boundary_target)
    y[i]<-runif(1,boundary_target, plot_maxy-boundary_target)
  }
# random number generator for radius and background color of each point
  radius_randA<-runif(first_points,min_size,number_radii)  # size of first_points are larger than the rest
  radius_randB<-runif(rest_points,1,number_radii)        # rest of points come from all sizes of radii
  radius_rand<-c(radius_randA,radius_randB)              # join two lists together
  bgd_rand<-runif(number_points,1,number_colors)         # randomly set color of each background point
# set up plot
  par(mar=c(0,0,0,0))  # set 0 margins to reduce white space
# set size of plot based on plot_maxx and plot_maxy; aspect ratio is 1 and no axes
  plot(x,y,xlim=c(0,plot_maxx), ylim=c(0,plot_maxy),asp=1,type="n", axes=FALSE)
# generate and plot target and then all the background points
# plot target = very first point
  k<-1
  for (m in 1:number_targets) {
    current_radius[m]<-radius[as.integer(radius_rand[m])]
    # set the border of the spots to be NULL so hopefully no overlap
    draw.circle(x[m],y[m],current_radius[m],border=target_color[m],col=target_color[m])
    xhold[k]<-x[m]   # the hold variables will be used to hold the points that have been plotted
    yhold[k]<-y[m]     # and future points will be compared to those locations to make sure they don't overlap
    radhold[m]<-current_radius[m]
    test_overlap[m]<-0
    k<-k+1
  }
for (i in k:number_points) {
  current_radius[i]<-radius[as.integer(radius_rand[i])]
  current_R[i]<-(R[as.integer(bgd_rand[i])])/255   # convert RGB to plottable color
  current_G[i]<-(G[as.integer(bgd_rand[i])])/255
  current_B[i]<-(B[as.integer(bgd_rand[i])])/255
  current_color[i]<-rgb(current_R[i],current_G[i],current_B[i])  
  test_overlap[i]<-0
  for (j in 1:(k-1)) {
    criteria[i,j]<-sqrt((x[i]-xhold[j])^2+(y[i]-yhold[j])^2)-((current_radius[i]+radhold[j])+overlap_buffer)  # distance between centers must be > sum of radii
    if (criteria[i,j]<0) {
      test_overlap[i]<-test_overlap[i]+1
     } # of if
  }   # of j
  if (test_overlap[i]==0) {      # if no overlap then plot circle
    draw.circle(x[i],y[i],current_radius[i],border=current_color[i],col=current_color[i])
    xhold[k]<-x[i]        # if draw circle add it to list to test for overlap
    yhold[k]<-y[i]
    radhold[k]<-current_radius[i]
    k<-k+1
      }  # of if
  }  # of i

#####  output data
#out_file1<-"Possible_spots.txt"
#out_file2<-"Actual_spots.txt"
#out_file3<-"Criteria.txt"
#out_file4<-"testoverlap.txt"
#data<-cbind(x,y,current_radius)
#datahold<-cbind(xhold,yhold,radhold)
#write.table(data, file=out_file1, sep="\t", quote= FALSE)
#write.table(datahold, file=out_file2, sep="\t", quote= FALSE)
#write.table(criteria, file=out_file3, sep="\t", quote= FALSE)
#write.table(test_overlap, file=out_file4, sep="\t", quote= FALSE)