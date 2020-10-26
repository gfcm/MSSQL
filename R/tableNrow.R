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
#' \code{\link{nrow}} is the base function to return the number of rows for
#' objects inside the R workspace.
#'
#' \code{\link{dbTools-package}} gives an overview of the package.
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
  ## 1  Quote table name if not already quoted
  if(!grepl("\"", sqtable))
  {
    s <- unlist(strsplit(sqtable, "\\."))  # split schema from table name
    sqtable <- if(length(s) == 1)
                 paste0("\"", s, "\"")            # "\"table name\""
               else
                 paste0(s[1], ".\"", s[2], "\"")  # "schema.\"table name\""
  }

  ## 2  Query number of rows
  query <- paste("SELECT COUNT(*) FROM", sqtable)
  x <- sqlQuery(channel, query, errors=FALSE)
  x <- as.integer(unname(unlist(x)))

  ## 3  Convert error code to NA
  if(x < 0)
    x <- NA_integer_

  x
}
