
data { /* these are known and passed as a named list from R */
  int<lower = 0> I;             // number of cases in day t 
  real<lower = 0> infect;  // weighted sum of previous infectivity 
  real<lower = 0> alpha; //shape parameter of gamma prior 
  real<lower =  0> beta;// rate parameter of gamma prior 
  real<lower = 0> mu; //location parameter of cauchy prior
  real<lower = 0> sigma;//scale parameter of cauchy prior
  int<lower = 0, upper = 1> prior_only;
}

parameters { 
  real<lower=0> Rt; // Reproduction number 
  real<lower=0> phi; // dispersion parameter
}



model { 
if (!prior_only) {
  target +=neg_binomial_2_lpmf(I | Rt*infect, phi); // log-likelihood
  }
  target += gamma_lpdf(Rt | alpha, beta); //prior of Rt
  target += cauchy_lpdf(phi | mu, sigma); //prior of phi
}
