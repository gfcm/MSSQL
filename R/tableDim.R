#' Table Dimensions
#'
#' Return the number of rows and columns in a database table.
#'
#' @param channel an RODBC connection.
#' @param sqtable a database table or view.
#'
#' @return Vector of length two, containing the number of rows and columns.
#'
#' @seealso
#' \code{\link{tableNrow}} and \code{\link{tableNcol}} are the underlying
#' functions to get the number of rows and columns in a database table.
#'
#' \code{\link{dim}} is the base function to return the dimensions for data
#' frames inside the R workspace.
#'
#' \code{\link{dbTools-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' con <- odbcConnect("myDatabase")
#'
#' tableDim(con, "sysusers")
#' }
#'
#' @export

tableDim <- function(channel, sqtable)
{
  nr <- tableNrow(channel, sqtable)
  nc <- tableNcol(channel, sqtable)
  c(nr, nc)
}
