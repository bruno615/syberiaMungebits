#' Converts a logical / numeric / character vector or a function
#' into a character vector of column names for a dataframe.
#'
#' If a function is provided, it will be applied to each column of
#' the dataframe and must return a logical; those with resulting value TRUE
#' will be returned as a character vector.
#'
#' @param cols a vector or function. If logical / numeric / character vector,
#'    it will attempt to find those columns matching these values. If \code{cols}
#'    is a function, it will apply this function to each column of the dataframe
#'    and return the names of columns for which it was \code{TRUE}.
#' @param dataframe a reference dataframe. Necessary for computing the
#'    column names if a numeric or logical vector is specified for \code{cols}.
#' @export
#' @examples
#' standard_column_format(c(1,5), iris)  # c('Sepal.Length', 'Species')
#' standard_column_format(c(TRUE,FALSE,FALSE,FALSE,TRUE), iris)  # c('Sepal.Length', 'Species')
#' standard_column_format('Sepal.Length', iris)  # 'Sepal.Length'

standard_column_format <- function(cols, dataframe) {
  if (missing(dataframe)) stop('No dataframe provided')
  missingcols <- missing(cols)
  eval(substitute(
   if (missingcols) colnames(dataframe)
   else if (is.function(cols)) colnames(dataframe)[vapply(dataframe, cols, logical(1))]
   else if (is.character(cols)) force(cols) 
   else colnames(dataframe)[cols]
  ), envir = parent.frame())
}

