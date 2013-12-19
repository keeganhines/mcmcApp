library(shiny)
library(ggplot2)
library(grid)
source('./helperFunctions.R')

shinyServer(function(input,output){
	
	
	output$something<-renderText({input$iterations})
	
	output$traj<-renderPlot({
		data<-curve(input$theta,seq(1,2000))+rnorm(2000,0,input$sigma)
		output<-mcmc(data,input$iterations,init_param=c(input$theta+floor(.1*input$theta),.05),trans=c(input$theta_trans,input$sigma_trans))
		output$time<-seq(1,nrow(output))
		par(mar=c(5,5,0,0))
		p1<-ggplot(data=output,aes(x=time,y=theta)) + geom_line(size=1,colour='#2B8CBE')
		p2<-ggplot(data=output,aes(x=time,y=sigma)) + geom_line(size=1,colour='#2B8CBE')
		multiplot(p1,p2)
		
		#plot(output$theta,ylab='Theta',xlab='Iteration',type='l')
		#plot(output$sigma,ylab='Sigma',xlab='Iteration',type='l')
	})
	
	output$distplot<- renderPlot({
		#par(mar=c(5,5,0,0))
		data<-curve(input$theta,seq(1,2000))+rnorm(2000,0,input$sigma)
		DATA<-data.frame(signal=data,time=seq(1,length(data)))
		p1<-ggplot(data=DATA,aes(x=time,y=signal)) + geom_line(size=1,colour='#00000080') +theme(plot.margin=unit(c(1,1,0,0), 'cm'))
		
		
		#plot(data,ylab='Signal',xlab='Time',type='l')
		out<-mcmc(data,input$iterations,init_param=c(input$theta,.05),trans=c(input$theta_trans,input$sigma_trans,.01))
		
		p2<-ggplot(data=out,aes(x=theta)) + geom_histogram(binwidth=ceiling((range(out$theta)[2] - range(out$theta)[1])/25),fill='#2B8CBE')
		
		
		#hist(output$theta[floor(input$iterations*.2):input$iterations],main='',xlab='Theta')
		multiplot(p1,p2)
	})
	
	
	
	
})
