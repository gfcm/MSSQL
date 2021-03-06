#' Number of Rows
#'
#' Return the number of rows in a database table.
#'
#' @param channel an RODBC connection.
#' @param sqtable a database table or view.
#'
#' @return Number of rows as integer.
#'
#' @seealso
#' \code{\link{tableDim}} and \code{\link{tableNcol}} also return the dimensions
#' of a database table.
#'
#' \code{\link{sqlQuery}} is the underlying function used to examine the table
#' rows.
#'
#' \code{\link{nrow}} is the base function to return the number of rows for data
#' frames inside the R workspace.
#'
#' \code{\link{MSSQL-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' con <- odbcConnect("myDatabase")
#'
#' tableNrow(con, "sysusers")
#' }
#'
#' @importFrom RODBC sqlQuery
#'
#' @export

tableNrow <- function(channel, sqtable)
{
  query <- paste("SELECT COUNT(*) FROM", tableQuote(sqtable))
  x <- sqlQuery(channel, query, errors=FALSE, stringsAsFactors=FALSE)
  x <- as.integer(unname(unlist(x)))
  if(x < 0)
    x <- NA_integer_
  x
}
