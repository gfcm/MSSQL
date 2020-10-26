#' Time Information about Tables and Views
#'
#' Get time information about tables and views: when they were created and when
#' they were last modified.
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
#' @note
#' The date and and time information is queried from \verb{sys.tables} and
#' \verb{sys.views}. If these do not exist, the function will return a harmless
#' ODBC error.
#'
#' @seealso
#' \code{\link{Sys.time}} is the base function to show the current date and
#' time.
#'
#' \code{\link{dbTools-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' con <- odbcConnect("myDatabase")
#'
#' dbTime(con)
#' }
#'
#' @importFrom RODBC sqlQuery
#'
#' @export

dbTime <- function(channel)
{
  tables <- sqlQuery(channel,
                     "SELECT name,type,create_date,modify_date FROM sys.tables
                      UNION
                      SELECT name,type,create_date,modify_date FROM sys.views",
                     stringsAsFactors=FALSE)
  tables$type <- trimws(tables$type)
  tables
}
