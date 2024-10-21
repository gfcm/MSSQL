#' @name MSSQL-package
#'
#' @aliases MSSQL
#'
#' @title Tools to Work with Microsoft SQL Server Databases via RODBC
#'
#' @description
#' Tools that extend the functionality of the \pkg{RODBC} package to work with
#' Microsoft SQL Server databases. Makes it easier to browse the database and
#' examine individual tables and views.
#'
#' @details
#' \emph{Browse database:}
#' \tabular{ll}{
#'   \code{\link{dbOverview}} \tab Dimensions and column names\cr
#'   \code{\link{dbStorage}}  \tab Storage size\cr
#'   \code{\link{dbTime}}     \tab Time created and modified
#' }
#' \emph{Browse table:}
#' \tabular{ll}{
#'   \code{\link{tableDim}}      \tab Dimensions\cr
#'   \code{\link{tableHead}}     \tab First rows\cr
#'   \code{\link{tableNcol}}     \tab Number of columns\cr
#'   \code{\link{tableNrow}}     \tab Number of rows\cr
#'   \code{\link{tableOverview}} \tab Data types and dimensions
#' }
#' \emph{Helper functions:}
#' \tabular{ll}{
#'   \code{\link{tableQuote}} \tab Quote table name
#' }
#'
#' @note
#' \code{browseVignettes()} shows a vignette with implementation notes.
#'
#' @seealso
#' This package complements the \pkg{RODBC} package and does not replace the
#' standard query methods.
#'
#' For example, the user may find \code{\link{dbOverview}} and
#' \code{\link{tableOverview}} more convenient than the underlying
#' \code{\link{sqlTables}} and \code{\link{sqlColumns}}, but to query the
#' database \code{sqlQuery} or \code{sqlFetch} are still used in the normal way.
#'
#' @author Arni Magnusson.

"_PACKAGE"
