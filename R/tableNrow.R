#' Number of Rows
#'
#' Return the number of rows in a database table.
#'
#' @param channel an RODBC connection.
#' @param sqtable a database table or view.
#'
#' @return Number of rows as integer.
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
