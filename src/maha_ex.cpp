﻿// [[Rcpp::depends(RcppArmadillo)]]
#define ARMA_64BIT_WORD
#include <RcppArmadillo.h>

#include "Rfast.h"
using namespace Rcpp;

NumericVector mahaInt(arma::mat& X, arma::vec& mu, arma::mat& sigma, const bool isChol);

/*
 *  Internal C++ function for Mahalanobis distance
 */
RcppExport SEXP Rfast_mahaCpp(SEXP XSEXP, SEXP muSEXP, SEXP sigmaSEXP, SEXP isCholSEXP) {
	BEGIN_RCPP
	RObject __result = wrap(NA_REAL);
	RNGScope __rngScope;
	NumericMatrix X(XSEXP);
	NumericVector mu(muSEXP);
	NumericMatrix sigma(sigmaSEXP);
	traits::input_parameter<bool>::type isChol(isCholSEXP);

	try {
    arma::mat X_(X.begin(), X.nrow(), X.ncol(), false), sigma_(sigma.begin(), sigma.nrow(), sigma.ncol(), false);
    arma::vec mu_(mu.begin(), mu.size(), false);
		NumericVector dist = mahaInt(X_, mu_, sigma_, isChol);
		__result = dist;

	} catch (std::exception& __ex__) {
		forward_exception_to_r(__ex__);
	} catch (...) {
		::Rf_error("c++ exception (unknown reason)");
	}
	return __result;
	END_RCPP
}