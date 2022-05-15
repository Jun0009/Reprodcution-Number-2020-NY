
data { /* these are known and passed as a named list from R */
  int<lower = 0> I;             // number of cases in day t 
  real<lower = 0> infect;  // weighted sum of previous infectivity 
  real<lower = 0> alpha; //shape parameter of gamma prior 
  real<lower =  0> beta;// rate parameter of gamma prior 
  int<lower = 0, upper = 1> prior_only;
}

parameters { 
  real<lower=0> Rt; // Reproduction number 
}

model { 
if (!prior_only) {
  target +=poisson_lpmf(I | Rt*infect); // log-likelihood
  }
  target += gamma_lpdf(Rt | alpha, beta); //prior of Rt
}
