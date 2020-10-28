#' Storage Size
#'
#' Get storage size of tables in a database.
#'
#' @param channel an RODBC connection.
#' @param total whether to calculate total storage size.
#' @param used whether to calculate used storage size.
#' @param unused whether to calculate unused storage size.
#'
#' @return
#' Data frame containing the following columns:
#' \item{Name}{name of table/view.}
#' \item{Schema}{database schema.}
#' \item{Type}{type of table/view.}
#' \item{Rows}{number of rows.}
#' \item{Cols}{number of columns.}
#' In addition, any of the following columns, depending on which of
#' \code{total}, \code{used}, and \code{unused} are \code{TRUE}:
#' \item{TotalKB}{total storage size.}
#' \item{UsedKB}{used storage size.}
#' \item{UnusedKB}{unused storage size.}
#'
#' @note
#' Based on \url{https://stackoverflow.com/questions/7892334}.
#'
#' @seealso
#' \code{\link{sqlQuery}} is the underlying function used to query
#' \verb{sys.tables}, \verb{sys.indexes}, \verb{sys.partitions},
#' \verb{sys.allocation_units}, and \verb{sys.schemas}.
#'
#' \code{\link{dbOverview}} shows the dimensions of tables/views and the first
#' column names, and \code{\link{dbTime}} shows the time when tables/views were
#' created and last modified.
#'
#' \code{\link{object.size}} is the base function to return the storage size of
#' objects inside the R workspace.
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
#' @importFrom RODBC sqlQuery
#'
#' @export

dbStorage <- function(channel, total=TRUE, used=FALSE, unused=FALSE)
{
  ## 1  Prepare and submit query
  query <- paste(
    "SELECT",
    "t.name AS TableName,",
    "s.name AS SchemaName,",
    "p.rows AS Rows,",
    "t.max_column_id_used AS Cols,",
    "SUM(a.total_pages) * 8 AS TotalKB,",
    "SUM(a.used_pages) * 8 AS UsedKB",
    "FROM",
    "sys.tables t",
    "INNER JOIN",
    "sys.indexes i ON t.object_id = i.object_id",
    "INNER JOIN",
    "sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id",
    "INNER JOIN",
    "sys.allocation_units a ON p.partition_id = a.container_id",
    "LEFT OUTER JOIN",
    "sys.schemas s ON t.schema_id = s.schema_id",
    "WHERE",
    "t.name NOT LIKE 'dt%'",
    "AND t.is_ms_shipped = 0",
    "AND i.object_id > 255",
    "GROUP BY",
    "t.name, s.name, p.rows, t.max_column_id_used")
  x <- sqlQuery(channel, query, stringsAsFactors=FALSE)

  ## 2  Prepare and return data frame
  out <- data.frame(Name=x$TableName, Schema=x$SchemaName, Type="Table",
                    Rows=x$Rows, Cols=x$Cols)
  if(total)
    out$TotalKB <- x$TotalKB
  if(used)
    out$UsedKB <- x$UsedKB
  if(unused)
    out$UnusedKB <- x$TotalKB - x$UsedKB

  out
}
