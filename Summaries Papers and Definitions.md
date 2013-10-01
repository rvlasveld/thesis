Summaries Papers and Definitions
================================


## Terms and definition

### Bayesian Nonparametric statistics

"Nonparametric" here does not mean a parameter-less model, rather a model in which representations grow as more data are observed.
(http://en.wikipedia.org/wiki/Dirichlet_process#Applications_of_the_Dirichlet_process)

### Dirichlet Process

In probability theory, a Dirichlet process is a random process that is a probability distribution whose domain is itself a random distribution.
Given a Dirichlet process DP(H,a) where *H* is an arbitrary distribution and *a* is a positive real number, a draw from DP will return a random distribution (the *output distribution*) containing values drawn from *H*.
(http://en.wikipedia.org/wiki/Dirichlet_process)

The Dirichlet Distribution gives the probability of a particular distribution given we have observed some counts of each outcome (having done repeated trials). Thus, we have a distribution over distributions.
(http://www.clg.ox.ac.uk/abstracts/2010hilary/Exciting_Guide_to_Probability_Distributions-part2.pdf)

### Beta Distribution
The Beta Distribution is a special case of the Dirichlet Distribution, where we have just two outcomes; given a number of successes out of *n* trails, what is the probability that our success probability *p* has a particular value? E.g. given we flipped a coin 100 times and got 50 heads, what is the probability that p(H) = 0.5?

### Conjugate Priors
Given a likelihood, the *conjugate prior* is the prior distribution such that the prior and the posterior are in the same famility of distributions.

For:

* Bernoulli, Binomial --> Beta distribution
* Mulitonomial and categorical distributions --> Dirichlet distribution
* Poisson --> Gamma

### Switching processes
E.g. Linear Dynamical System (LDS); For more complex time-series which are not well described globally by a single LDS, we may break the time-series into segments, each modeled by a potentially different LDS. This is the basis for the Switching LDS where, for each time-step *t*, a switch variable *s_t \in 1..S describes which of the LDSs is to be used. Also known as Jump Markov model/process, switching Kalman filter, Switching Linear Gaussian State-Space model, Conditional Linear Gaussian Model.
(Expectation Correction for Smoothed Inference in Switching
Linear Dynamical Systems - http://web4.cs.ucl.ac.uk/staff/d.barber/publications/barber_slds_jmlr_15nov06.pdf)

### Gibbs Sampling

* MLE: Maximum Likelihood Estimate produces the value for probability that was *most likely to have generated the observed data* by counting. E.g. for a coin with X = HHHTTTTTT, P(heads) = count(H) / (count(H)+count(T)) = 4 / 10 = 0.4
* MAP: Maximum A Posteriori estimates the parameter that is *most likely given the observed data*. MAP applies Bayes' Rule (MLE does not), so the estimate can take into account *prior knowledge*.

Both MLE and MAP through away information, only a single "best" estimate pi with a value between 0 and 1 is a result. Better to take the whole distribution of P(pi|X) into account, with an expected value for P.

* Expected value of a function f(z), when z is discrete: E[f(z)] = \sum_{z} f(z)p(z). When continuous, the expected value is an integral: E[f(z)] = F f(z)p(z)dz.

In this case y is the outcome of the next coin flip, z = pi and f(z) = P(y|pi) and the distribution over which we take the expectation is P(pi|X). This results in the following expected value for the posterior probability of y given X:
P(y|X) = F P(y|pi)P(pi|X)d.pi
With Bayes: P(pi|X) = (P(X|pi)P(pi)) / P(X) = (P(X|pi)P(pi)) / F_{pi} P(X|pi)P(pi)d.pi

In real world problems it can be hard to obtain the exact (integral) denominator as in the last formula, so we can not determine P(pi|X) [meaning: the probability of a parameter given the observations]. Gibbs sampling allows to sample from a distribution that *asymptotically follows* P(pi|X) without explicit integrals calculation.

* Monte Carlo: methods that help obtain a desired value by performing simulations involving probabilistic choices.

### Bernoulli Trial
A single experiment in which we draw from a distribution (e.g. coin flip), such that the outcome is _independent_ of previous trial (\ie the coin has no memory).

## Papers

### Bayesian nonparametric methods for learning Markov switching processes
Emily B. Fox, Erik B. Sudderth, Michael I. Jordan, and Alan S. Willsky

