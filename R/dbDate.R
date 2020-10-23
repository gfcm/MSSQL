#' Date Information about Tables and Views
#'
#' Get date and time information about tables and views: when they were created
#' and when they were last modified.
#'
#' @param channel an RODBC connection.
#'
#' @return
#' Data frame containing four columns:
#' \item{name}{name of table/view.}
#' \item{type}{type of table/view.}
#' \item{create_date}{date created.}
#' \item{modify_date}{date last modified.}
#'
#' @seealso
#' \code{\link{Sys.time}} is the base function to show the current date and
#' time.
#'
#' \code{\link{RODBCtools-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' dbDate(con)
#' }
#'
#' @importFrom RODBC sqlQuery
#'
#' @export

dbDate <- function(channel)
{
  tables <- sqlQuery(channel,
                     "SELECT name,type,create_date,modify_date FROM sys.tables
                      UNION
                      SELECT name,type,create_date,modify_date FROM sys.views",
                     stringsAsFactors=FALSE)
  tables$type <- trimws(tables$type)
  tables
}
