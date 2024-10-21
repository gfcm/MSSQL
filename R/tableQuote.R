#' Quote Table Name
#'
#' Add special quotes around table name.
#'
#' @param sqtable table name, with or without schema name.
#'
#' @return String with special quotes.
#'
#' @note
#' The \code{sqlQuery} function requires special quotes if the table name has
#' spaces. Furthermore, the schema name must not be inside the special quotes.
#'
#' @seealso
#' \code{\link[RODBC]{sqlQuery}} requires special quotes if the table name has
#' spaces.
#'
#' \code{\link{Quotes}} in base R.
#'
#' \code{\link{MSSQL-package}} gives an overview of the package.
#'
#' @examples
#' tableQuote("table")
#' tableQuote("table name")
#' tableQuote("schema.table")
#' tableQuote("schema.table name")
#'
#' @export

tableQuote <- function(sqtable)
{
  if(!grepl("\"", sqtable))
  {
    s <- unlist(strsplit(sqtable, "\\."))  # split schema from table name
    if(length(s) == 1)
      paste0("\"", s, "\"")            # "\"table name\""
    else
      paste0(s[1], ".\"", s[2], "\"")  # "schema.\"table name\""
  }
}
