#' First Rows
#'
#' Return the first rows of a database table.
#'
#' @param channel an RODBC connection.
#' @param sqtable a database table or view.
#' @param n number of rows to get.
#'
#' @return
#' Data frame with the first \code{n} rows of the database table or view.
#'
#' @note
#' This function can be used to examine the structure of a table or view, along
#' with some example data values.
#'
#' @seealso
#' \code{\link{sqlQuery}} with \code{\link{tableQuote}} are the underlying
#' functions used to query the table/view.
#'
#' \code{\link{head}} is the base function to return the first parts of an
#' object inside the R workspace.
#'
#' \code{\link{tableOverview}} shows the data types and dimensions of a database
#' table.
#'
#' \code{\link{dbTools-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' con <- odbcConnect("myDatabase")
#'
#' tableHead(con, "sysusers")
#'
#' t(tableHead(con, "sysusers", 1))
#' }
#'
#' @importFrom RODBC sqlQuery
#'
#' @export

tableHead <- function(channel, sqtable, n=3)
{
  query <- paste("SELECT * FROM", tableQuote(sqtable))
  sqlQuery(channel, query, max=n, stringsAsFactors=FALSE)
}
