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
#' \code{\link{sqlQuery}} is the underlying function used to examine the table.
#'
#' \code{\link{nrow}} is the base function to return the number of rows for
#' objects inside the R workspace.
#'
#' @examples
#' \dontrun{
#' tableNrow(con, "sysusers")
#' }
#'
#' @importFrom RODBC sqlQuery
#'
#' @export

tableNrow <- function(channel, sqtable)
{
  x <- sqlQuery(channel, paste0('SELECT COUNT(*) FROM "', sqtable, '"'))
  as.integer(unname(unlist(x)))
}
