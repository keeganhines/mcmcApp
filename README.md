mcmcApp
=======

R Shiny app for teaching about Metropolis Hastings

# Introduction

This app is a teaching tool for explaining Markov chain Monte Carlo sampling, and Metropolis random walk, in particular. The app is hosted at [rstudio] (spark.rstudio.com/khines/mcmc). 

# Data

The signal from which we estimate parameters is assumed to be an exponentially decaying curve.

# User Controlled Parameters

The user can adjust *data parameters* as well as *algorithm parameters*. The data parameters adjust the characteristics of the input signal. The parameter *Theta* is the time scale of the exponential decay curve and the parameter **Noise** is the standard deviation of Gaussian noise which is added to the signal. The use can adjust three algorithm parameters. The parameter **iterations** specifies how any iterations of MCMC will be computed. Typically more than 1000 is desirable, but this is initialized at 100 to speed up the UI. The parameters relating to **step size** refer to the random walk step sizes that the Markov chain takes in each dimension. 

# Tabs

The **Plot** tab shows, at top, the data which is used for parameter inference, and, at bottom, a histogram of the samples from the marginal posterior distribution of **Theta**. 

The **Trajectories** tab shows the evolution of each dimension of the Markov chain throughout the course of the simulation. In particular, note the effect of changing the transition **step sizes** to either vary large or very small values. Note how this relates to *burn in* and the *mixing* of the Markov chain.