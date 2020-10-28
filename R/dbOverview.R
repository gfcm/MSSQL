#' Overview of Tables and Views
#'
#' Get dimensions and first few column names of tables and views in a database.
#'
#' @param channel an RODBC connection.
#' @param schema database schema.
#' @param dim whether to calculate the number of rows and columns for each
#'        table/view.
#' @param peek how many column names to show. The value \code{FALSE} has the
#'        same effect as zero.
#' @param \dots passed to \code{sqlTables}.
#'
#' @details
#' The \code{dim = FALSE} option results in faster computation, but the
#' \verb{Rows} and \verb{Cols} columns will only contain \code{NA} values.
#' Similarly, the \code{peek = FALSE} results in faster computation, but the
#' \verb{First} column will only contain \code{NA} values. These options can be
#' useful to get a quick overview of a large database.
#'
#' @return
#' Data frame containing six columns:
#' \item{Name}{name of table/view.}
#' \item{Schema}{database schema.}
#' \item{Type}{type of table/view.}
#' \item{Rows}{number of rows.}
#' \item{Cols}{number of columns.}
#' \item{First}{first column names.}
#'
#' @seealso
#' \code{\link{sqlTables}} is the underlying function used to get the list of
#' tables/views, \code{\link{tableDim}} is used to count rows and columns, and
#' \code{\link{sqlColumns}} is used to peek at the first column names.
#'
#' \code{\link{dbStorage}} shows the storage size of tables and
#' \code{\link{dbTime}} shows the time when tables/views were created and last
#' modified.
#'
#' \code{\link{MSSQL-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' con <- odbcConnect("myDatabase")
#'
#' dbOverview(con)
#'
#' dbOverview(con, dim=FALSE, peek=FALSE)
#' }
#'
#' @importFrom RODBC sqlColumns sqlTables
#' @importFrom tools toTitleCase
#' @importFrom utils head
#'
#' @export

dbOverview <- function(channel, schema="dbo", dim=TRUE, peek=2, ...)
{
  peekCols <- function(tab, peek)
    paste(head(sqlColumns(channel, tab)[[4]], peek), collapse=" | ")

  ## 1  Get tables and prepend schema name
  tables <- sqlTables(channel, schema=schema, ...)
  tabs <- paste(tables[[2]], tables[[3]], sep=".")

  dims <- if(isTRUE(dim))
            sapply(tabs, tableDim, channel=channel)
          else
            matrix(NA_integer_, nrow=2, ncol=length(tabs))
  first <- if(peek > 0L)
             sapply(tabs, function(x) peekCols(tab=x, peek=peek))
           else
             rep("", length(tabs))

  out <- data.frame(Name=tables[[3]], Schema=tables[[2]],
                    Type=toTitleCase(tables[[4]]), Rows=dims[1,], Cols=dims[2,],
                    First=first, row.names=NULL, stringsAsFactors=FALSE)
  out
}
