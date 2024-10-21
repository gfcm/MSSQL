#' Data Types and Dimensions
#'
#' Show data types and dimensions of a database table.
#'
#' @param channel an RODBC connection.
#' @param sqtable a database table or view.
#' @param max number of rows to analyze the resulting data frame columns in R.
#'        Pass \code{max = 0} to analyze the entire database table.
#'
#' @return
#' List containing \code{Cols} and \code{Rows}, describing column data types and
#' the number of rows.
#'
#' @seealso
#' \code{\link[RODBC]{sqlColumns}}, \code{\link[RODBC]{sqlQuery}}, and
#' \code{\link{tableNrow}} are the underlying functions used to examine the
#' table/view.
#'
#' \code{\link{class}} is the base function to show the class of an object
#' inside the R workspace.
#'
#' \code{\link{tableHead}} returns the first rows of a database table.
#'
#' \code{\link{MSSQL-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' con <- odbcConnect("myDatabase")
#'
#' tableOverview(con, "sysusers")
#'
#' tableOverview(con, "sysusers")$Cols
#' }
#'
#' @importFrom RODBC sqlColumns sqlQuery
#'
#' @export

tableOverview <- function(channel, sqtable, max=1000)
{
  x <- sqlColumns(channel, sqtable)
  cols <- data.frame(Column=x$COLUMN_NAME, DB=x$TYPE_NAME)

  query <- paste("SELECT * FROM", tableQuote(sqtable))
  y <- sqlQuery(channel, query, max=max, stringsAsFactors=FALSE)
  cols$R <- sapply(y, function(x) class(x)[1])

  rows <- tableNrow(channel, sqtable)
  list(Cols=cols, Rows=rows)
}
