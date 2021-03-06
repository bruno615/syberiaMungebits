% Generated by roxygen2 (4.0.2): do not edit by hand
\name{drop_percent_missing_fn}
\alias{drop_percent_missing_fn}
\title{Drop columns with over a certain percent missing.}
\usage{
drop_percent_missing_fn(x, threshold = 0.8)
}
\arguments{
\item{x}{any. The column to screen.}

\item{threshold}{numeric. The percent (e.g., 0.5) below which to remove
column that have at least that percent missing. The default is 0.8.}
}
\description{
Drop columns with over a certain percent missing.
}
\examples{
df <- iris; df[, 6] <- NA; df[1, 6] <- 1; df <- mungebits:::mungeplane(df)
mb <- mungebits:::mungebit(drop_percent_missing)
mb$run(df, TRUE, 0.8) # Drop sixth column
}
\seealso{
\code{\link{drop_percent_missing}}
}

