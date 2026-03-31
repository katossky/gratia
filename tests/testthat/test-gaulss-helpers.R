# Tests for gaulss family distribution helpers
# make_cdf_gaulss : CDF for Gaussian location-scale family
# make_qf_gaulss  : quantile function for Gaussian location-scale family

# helper : construit un mu a deux colonnes comme le ferait predict() sur gaulss
make_gaulss_mu <- function(mean_val, sigma_val, n = 1) {
  # mu[,1] = mean, mu[,2] = log(sigma) car gaulss estime log(sigma)
  cbind(
    rep(mean_val,       n),
    rep(log(sigma_val), n)
  )
}

# ─────────────────────────────────────────
# Tests pour make_cdf_gaulss
# ─────────────────────────────────────────

test_that("make_cdf_gaulss: P(X <= mu) = 0.5", {
  cdf <- make_cdf_gaulss()
  mu  <- make_gaulss_mu(mean_val = 10, sigma_val = 2)

  # la mediane d'une gaussienne est sa moyenne
  result <- cdf(q = 10, mu = mu, wt = NULL, scale = NULL)
  expect_equal(result, 0.5)
})

test_that("make_cdf_gaulss: resultat entre 0 et 1", {
  cdf <- make_cdf_gaulss()
  mu  <- make_gaulss_mu(mean_val = 0, sigma_val = 1)

  result <- cdf(q = c(-10, 0, 10), mu = mu[rep(1,3), ], wt = NULL, scale = NULL)
  expect_true(all(result >= 0 & result <= 1))
})

test_that("make_cdf_gaulss: CDF croissante", {
  cdf <- make_cdf_gaulss()
  # une seule observation (n=1) pour avoir un scalaire en retour
  mu  <- make_gaulss_mu(mean_val = 5, sigma_val = 2, n = 1)

  p1 <- cdf(q = 3, mu = mu, wt = NULL, scale = NULL)
  p2 <- cdf(q = 5, mu = mu, wt = NULL, scale = NULL)
  p3 <- cdf(q = 8, mu = mu, wt = NULL, scale = NULL)

  expect_lt(p1, p2)
  expect_lt(p2, p3)
})
test_that("make_cdf_gaulss: sigma plus grand = courbe plus etalee", {
  cdf_narrow <- make_cdf_gaulss()
  cdf_wide   <- make_cdf_gaulss()

  mu_narrow <- make_gaulss_mu(mean_val = 0, sigma_val = 1)
  mu_wide   <- make_gaulss_mu(mean_val = 0, sigma_val = 5)

  # au meme point q > mu, une sigma plus grande = probabilite plus faible
  p_narrow <- cdf_narrow(q = 3, mu = mu_narrow, wt = NULL, scale = NULL)
  p_wide   <- cdf_wide(  q = 3, mu = mu_wide,   wt = NULL, scale = NULL)

  expect_gt(p_narrow, p_wide)
})

# ─────────────────────────────────────────
# Tests pour make_qf_gaulss
# ─────────────────────────────────────────

test_that("make_qf_gaulss: Q(0.5) = mu", {
  qf <- make_qf_gaulss()
  mu <- make_gaulss_mu(mean_val = 7, sigma_val = 3)

  result <- qf(p = 0.5, mu = mu, wt = NULL, scale = NULL)
  expect_equal(result, 7)
})

test_that("make_qf_gaulss applique sigma correctement", {
  qf_s1 <- make_qf_gaulss()
  qf_s3 <- make_qf_gaulss()

  mu_s1 <- make_gaulss_mu(mean_val = 0, sigma_val = 1)
  mu_s3 <- make_gaulss_mu(mean_val = 0, sigma_val = 3)

  # Q(0.9) avec sigma=3 doit etre 3x plus eloigne de mu que sigma=1
  q_s1 <- qf_s1(p = 0.9, mu = mu_s1, wt = NULL, scale = NULL)
  q_s3 <- qf_s3(p = 0.9, mu = mu_s3, wt = NULL, scale = NULL)

  expect_equal(q_s3, 3 * q_s1)
})

test_that("make_qf_gaulss: lower_tail = FALSE fonctionne", {
  qf <- make_qf_gaulss()
  mu <- make_gaulss_mu(mean_val = 0, sigma_val = 1, n = 1)

  q_lower <- qf(p = 0.9, mu = mu, wt = NULL, scale = NULL, lower_tail = TRUE)
  q_upper <- qf(p = 0.1, mu = mu, wt = NULL, scale = NULL, lower_tail = FALSE)

  expect_equal(q_lower, q_upper)
})

test_that("make_qf_gaulss et make_cdf_gaulss sont inverses", {
  cdf <- make_cdf_gaulss()
  qf  <- make_qf_gaulss()
  mu  <- make_gaulss_mu(mean_val = 5, sigma_val = 2)

  p_val <- 0.8

  # qf puis cdf doit redonner p
  q <- qf(p = p_val, mu = mu, wt = NULL, scale = NULL)
  p_back <- cdf(q = q, mu = mu, wt = NULL, scale = NULL)

  expect_equal(p_back, p_val, tolerance = 1e-10)
})
