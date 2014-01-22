library(shiny)

shinyUI(pageWithSidebar(

	
	headerPanel(""),
	sidebarPanel(
		helpText('Data Parameters:'),
		sliderInput('theta','Theta',min=50,max=1000,value=450),
		sliderInput('sigma','Noise Level ',min=.01,max=.25,value=.03),
		
		
		helpText('Algorithm Parameters:'),
		numericInput('iterations',"Iterations",100),
		sliderInput('theta_trans','Theta Transitions',min=.1,max=10,value=1),
		sliderInput('sigma_trans','Noise Transitions',min=.0001,max=.01,value=.001)
		
				), #close sidebarPanel
	mainPanel(
		tabsetPanel(	
			tabPanel('Plot',
				plotOutput("distplot")
				),
			tabPanel("Trajectories",
				plotOutput('traj')
			
			 )
	)#close tabsetP
	)#close mainPanel


))#close shinyUI
