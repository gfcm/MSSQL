#' Time Information about Tables and Views
#'
#' Get time information about tables and views: when they were created and when
#' they were last modified.
#'
#' @param channel an RODBC connection.
#'
#' @return
#' Data frame containing four columns:
#' \item{Schema}{database schema.}
#' \item{Name}{name of table/view.}
#' \item{Type}{type of table/view.}
#' \item{Created}{time created.}
#' \item{Modified}{time last modified.}
#'
#' @seealso
#' \code{\link{sqlQuery}} is the underlying function used to query
#' \verb{sys.tables} and \verb{sys.views}.
#'
#' \code{\link{Sys.time}} is the base function to show the current time.
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
  query <- paste("SELECT name,type,create_date,modify_date FROM sys.tables",
                 "UNION",
                 "SELECT name,type,create_date,modify_date FROM sys.views")
  x <- sqlQuery(channel, query, stringsAsFactors=FALSE)
  type <- ifelse(trimws(x$type)=="V", "View", "Table")

  out <- data.frame(Schema="dbo", Name=x$name, Type=type, Created=x$create_date,
                    Modified=x$modify_date)
  out
}
