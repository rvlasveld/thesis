Summaries Papers and Definitions
================================


## Terms and definition

### Bayesian Nonparametric statistics

"Nonparametric" here does not mean a parameter-less model, rather a model in whick representations grow as more data are abserved.
(http://en.wikipedia.org/wiki/Dirichlet_process#Applications_of_the_Dirichlet_process)

### Dirichlet Process

In probability theory, a Dirichlet process is a random process that is a probability distribution whose domein is itself a random distribution.
Given a Dirichlet process DP(H,a) where *H* is an arbitrary distribution and *a* is a positive real number, a draw from DP will return a random distribution (the *output distribution*) containing values drawn from *H*.
(http://en.wikipedia.org/wiki/Dirichlet_process)

### Switching processes
E.g. Linear Dynamical System (LDS); For more complex time-series which are not well described globally by a single LDS, we may break the time-eries into segments, each modeled by a potentially different LDS. This is the basis for the Switching LDS where, for each time-step *t*, a switch variable *s_t \in 1..S describes which of the LDSs is to be used. Also known as Jump Markov model/process, switching Kalman filter, Switching Linear Gaussian State-Space model, Conditional Linear Gaussian Model.
(Expectation Correction for Smoothed Inference in Switching
Linear Dynamical Systems - http://web4.cs.ucl.ac.uk/staff/d.barber/publications/barber_slds_jmlr_15nov06.pdf)


## Papers

### Bayesian nonparametric methods for learning Markov switching processes
Emily B. Fox, Erik B. Sudderth, Michael I. Jordan, and Alan S. Willsky

