# Quick-Start Tutorial for PoissonERM: Automate Analysis via Poisson Regression

PoissonERM is a package-like automation tool for implementing poisson regression in binary-endpoint(s) exposure-response (ER) analysis. Poisson regression is useful for estimating the incidence rate while time is considered as a factor. 

To install this tool 

    install.packages("devtools")
    library(devtools)
    install_github("yuchenw2015/PoissonERM",build = FALSE)
    
If see an error of "! System command 'Rcmd.exe' failed", try running 

    Sys.setenv(R_REMOTES_STANDALONE="true") 
    
before installation.

To use this tool, you will need:
  - A control script (user input) and a data set to fit the model(s).
  - A control script (prediction input) and a simulated/external exposure data set to create additional predicted incidence rates. This is optional.

The Examples of `PoissonERM` is here: https://github.com/yuchenw2015/PoissonERM-Example

The full method section is here: https://yuchenw2015.github.io/PoissonERM

Now start with the command.R to play with the examples!
