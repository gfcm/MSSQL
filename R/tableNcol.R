#' Number of Columns
#'
#' Return the number of columns in a database table.
#'
#' @param channel an RODBC connection.
#' @param sqtable a database table or view.
#'
#' @return Number of columns as integer.
#'
#' @seealso
#' \code{\link{tableDim}} and \code{\link{tableNrow}} also return the dimensions
#' of a database table.
#'
#' \code{\link[RODBC]{sqlColumns}} is the underlying function used to examine
#' the table columns.
#'
#' \code{\link{ncol}} is the base function to return the number of columns for
#' data frames inside the R workspace.
#'
#' \code{\link{MSSQL-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' con <- odbcConnect("myDatabase")
#'
#' tableNcol(con, "sysusers")
#' }
#'
#' @importFrom RODBC sqlColumns
#'
#' @export

tableNcol <- function(channel, sqtable)
{
  x <- sqlColumns(channel, sqtable)
  nrow(x)
}
