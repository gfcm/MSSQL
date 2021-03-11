[![CRAN Status](https://r-pkg.org/badges/version/MSSQL)](https://cran.r-project.org/package=MSSQL)
[![CRAN Monthly](https://cranlogs.r-pkg.org/badges/MSSQL)](https://cran.r-project.org/package=MSSQL)
[![CRAN Total](https://cranlogs.r-pkg.org/badges/grand-total/MSSQL)](https://cran.r-project.org/package=MSSQL)

MSSQL
=====

MSSQL provides tools that extend the functionality of the
[RODBC](https://cran.r-project.org/package=RODBC) package to work with Microsoft
SQL Server databases. Makes it easier to browse the database and examine
individual tables and views.

MSSQL is implemented as an [R](https://www.r-project.org) package and available
on [CRAN](https://cran.r-project.org/package=MSSQL).

Installation
------------

MSSQL can be installed from CRAN using the `install.packages` command:

```R
install.packages("MSSQL")
```

Usage
-----

For a summary of the package:

```R
library(MSSQL)
?MSSQL
```

Development
-----------

MSSQL is developed openly on [GitHub](https://github.com/gfcm/MSSQL).

Feel free to open an [issue](https://github.com/gfcm/MSSQL/issues) there if you
encounter problems or have suggestions for future versions.

The current development version can be installed using:

```R
library(remotes)
install_github("gfcm/MSSQL")
```
