curve<-function(parameter,timebase){
data<-exp(-timebase/parameter) 
return(data)
}



mcmc<-function(data,Iterations,init_param,trans=c(.1,.1)){
#Need to add in priors


theta<-c(init_param[1])
sigma<-c(init_param[2])
	
for (i in seq(1,Iterations)){
	
	#theta block
	theta_proposal<-tail(theta,1) + rnorm(1,0,trans[1])
	Old_LL<-sum(log(dnorm(data,   curve(tail(theta,1),seq(1,length(data))), tail(sigma,1))))
	Prop_LL <-sum(log(dnorm(data,   curve(theta_proposal,seq(1,length(data))), tail(sigma,1))))
	if (runif(1) < exp(Prop_LL-Old_LL)){
		theta<-c(theta,theta_proposal)
	}else{
		theta<-c(theta,tail(theta,1))
	}
	
	#sigma block
	sigma_proposal<-tail(sigma,1) + rnorm(1,0,trans[2])
	Old_LL<-sum(log(dnorm(data,   curve(tail(theta,1),seq(1,length(data))), tail(sigma,1))))
	Prop_LL <-sum(log(dnorm(data,   curve(tail(theta,1),seq(1,length(data))), sigma_proposal)))
	if (runif(1) < exp(Prop_LL-Old_LL)){
		sigma<-c(sigma,sigma_proposal)
	}else{
		sigma<-c(sigma,tail(sigma,1))
	}
	
	
}	
	
return(data.frame(theta=theta,sigma=sigma))
	
}


multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols))
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
