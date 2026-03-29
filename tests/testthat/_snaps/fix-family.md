# cdf fun works for gaussian cdf

    Code
      cdf_gaussian(q = c(-1, 3, 2.3), mu = c(0, 2, 1.5), wt = rep(1, 3), scale = c(1,
        2, 1))
    Output
      [1] 0.1586553 0.7602499 0.7881446

# cdf fun works for poisson cdf

    Code
      cdf_poisson(q = c(0, 1, 3), mu = c(0.1, 1.3, 3.5), wt = rep(1, 3), scale = c(1,
        1, 1))
    Output
      [1] 0.9048374 0.6268231 0.5366327

# cdf fun works for binomial cdf

    Code
      cdf_binomial(q = c(0.01, 0.7, 0.8), mu = c(0.1, 0.5, 0.7), wt = rep(1, 3),
      scale = c(1, 1, 1))
    Output
      [1] 0.9 0.5 0.3

# cdf fun works for gamma cdf

    Code
      cdf_gamma(q = c(1.1, 3.2, 2.3), mu = c(2, 2, 1.5), wt = rep(1, 3), scale = c(1,
        2, 1))
    Output
      [1] 0.4230502 0.7940968 0.7841849

# qf fun works for gaussian quantiles

    Code
      qf_gaussian(p = c(0.025, 0.5, 0.975), mu = c(0, 2, 1.5), wt = rep(1, 3), scale = c(
        1, 2, 1))
    Output
      [1] -1.959964  2.000000  3.459964

# qf fun works for poisson quantiles

    Code
      qf_poisson(p = c(0.1, 0.5, 0.9), mu = c(0.1, 1.3, 3.5), wt = rep(1, 3), scale = c(
        1, 1, 1))
    Output
      [1] 0 1 6

# qf fun works for scat (scaled t) quantiles

    Code
      qf_scat_test(p = c(0.025, 0.5, 0.975), mu = c(0, 10, 5), wt = rep(1, 3), scale = 1)
    Output
      [1] -6.364893 10.000000 11.364893

