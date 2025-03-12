test_that("est.riskfxn returns correct risk and se", {
  t_ <- c(1, 2, 3, 4, 10, 9, 10, 5, 2, 10)
  delta_ <- c(1, 0, 1, 0, 1, 0, 1, 0, 1, 0)
  est_risk <- est.riskfxn(t_, delta_)
  expect_equal(
    round(tail(est_risk, n = 1)$risk, 7),
    0.7714286
  )
  expect_equal(
    round(tail(est_risk, n = 1)$se, 6),
    0.193339
  )
})

test_that("get.risk returns correct risk", {
  t_ <- c(0, 1, 2, 3, 10)
  risk_ <- c(0, .1, .2, 0.3142857, 0.7714286)
  selected_risk <- get.risk(t_, risk_, 4)
  expect_equal(
    round(selected_risk, 7),
    0.3142857
  )
})

test_that("est.np.ab returns correct value with only missed events", {
  times_ <- c(0, 1, 2, 3, 10)
  w_ <- c(1, 2, 10, 4, 10, 9, 10, 5, 2, 10)
  eta_ <- c(1, 0, 0, 0, 1, 0, 1, 0, 1, 0)
  t_ <- c(1, 2, 3, 4, 10, 9, 10, 5, 2, 10)
  delta_ <- c(1, 0, 1, 0, 1, 0, 1, 0, 1, 0)
  ab <- est.np.ab(times_, w_, t_, eta_, delta_)
  expect_equal(
    ab$a[4],
    2/3
  )
})


test_that("est.np.ab returns correct value with missed events and delayed events", {
  times_ <- c(0, 1, 2, 3, 10)
  w_ <- c(4, 2, 10, 4, 10, 9, 10, 5, 2, 10)
  eta_ <- c(1, 0, 0, 0, 1, 0, 1, 0, 1, 0)
  t_ <- c(1, 2, 3, 4, 10, 9, 10, 5, 2, 10)
  delta_ <- c(1, 0, 1, 0, 1, 0, 1, 0, 1, 0)
  ab <- est.np.ab(times_, w_, t_, eta_, delta_)
  expect_equal(
    ab$a[4],
    1/3
  )
})


test_that("est.np.ab returns correct value with missed events, delayed events, and false positives", {
  times_ <- c(0, 1, 2, 3, 10)
  w_ <-   c(4, 2, 10, 4, 10, 2, 10, 5, 2, 10)
  eta_ <- c(1, 0, 0,  0, 1,  1, 1,  0, 1, 0)
  t_ <-     c(1, 2, 3, 4, 10, 9, 10, 5, 2, 10)
  delta_ <- c(1, 0, 1, 0, 1,  0, 1,  0, 1, 0)
  ab <- est.np.ab(times_, w_, t_, eta_, delta_)
  expect_equal(
    ab$b[4],
    1/6
  )
})


test_that("est.mc.params returns correct values with missed events, delayed events, and false positives", {
  times_ <- c(0, 1, 2, 3, 10)
  w_ <-   c(4, 2, 10, 4, 10, 2, 10, 5, 2, 10)
  eta_ <- c(1, 0, 0,  0, 1,  1, 1,  0, 1, 0)
  t_ <-     c(1, 2, 3, 4, 10, 9, 10, 5, 2, 10)
  delta_ <- c(1, 0, 1, 0, 1,  0, 1,  0, 1, 0)
  mcparms <- c(tail(est.mc.params(times_, w_, t_, eta_, delta_), n = 1))
  expect_equal(
    round(mcparms[1], 8),
    0.02040816
  )
  expect_equal(
    round(mcparms[2], 8),
    0.1
  )
  expect_equal(
    round(mcparms[3], 8),
    0.6
  )
})


test_that("np.cor works", {
  w_ <-   c(4, 2, 10, 4, 10, 2, 10, 5, 2, 10)
  eta_ <- c(1, 0, 0,  0, 1,  1, 1,  0, 1, 0)
  t_ <-     c(1, 2, 3, 4, 10, 9, 10, 5, 2, 10)
  delta_ <- c(1, 0, 1, 0, 1,  0, 1,  0, 1, 0)
  obsfxn_ <- est.riskfxn(w_, eta_) 
  ab <- est.np.ab(obsfxn_$time, w_, t_, eta_, delta_)
  cor <- np.cor(obsfxn_$time, obsfxn_$risk, ab$a, ab$b)
  
  expect_equal(
    round(tail(cor$risk, n = 1), 7),
    0.8214286
  )
})


test_that("p.cor works", {
  w_ <-   c(4, 2, 10, 4, 10, 2, 10, 5, 2, 10)
  eta_ <- c(1, 0, 0,  0, 1,  1, 1,  0, 1, 0)
  t_ <-     c(1, 2, 3, 4, 10, 9, 10, 5, 2, 10)
  delta_ <- c(1, 0, 1, 0, 1,  0, 1,  0, 1, 0)
  obsfxn_ <- est.riskfxn(w_, eta_) 
  parms <- est.mc.params(obsfxn_$time, w_, t_, eta_, delta_)
  cor <- p.cor(obsfxn_$time, obsfxn_$risk, parms[,1], parms[,2], parms[,3])

  expect_equal(
    round(tail(cor$risk, n = 1), 7),
    0.7658665
  )
})


test_that("analysis.np works", {
  w_ <-   c(4, 2, 10, 4, 10, 2, 10, 5, 2, 10)
  eta_ <- c(1, 0, 0,  0, 1,  1, 1,  0, 1, 0)
  t_ <-     c(1, 2, 3, 4, 10, 9, 10, 5, 2, 10)
  delta_ <- c(1, 0, 1, 0, 1,  0, 1,  0, 1, 0)
  cor <- analysis.np(w_, eta_, w_, t_, eta_, delta_, 10)
  
  expect_equal(
    round(cor, 7),
    0.8214286
  )
})


test_that("analysis.p works", {
  w_ <-   c(4, 2, 10, 4, 10, 2, 10, 5, 2, 10)
  eta_ <- c(1, 0, 0,  0, 1,  1, 1,  0, 1, 0)
  t_ <-     c(1, 2, 3, 4, 10, 9, 10, 5, 2, 10)
  delta_ <- c(1, 0, 1, 0, 1,  0, 1,  0, 1, 0)
  cor <- analysis.p(w_, eta_, w_, t_, eta_, delta_, 10)
  
  expect_equal(
    round(cor, 7),
    0.7658665
  )
})

