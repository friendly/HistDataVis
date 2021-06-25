# check figures in the database vs those in figs-web/

figureinfo <- openxlsx::read.xlsx("figureinfo/TOGS-lof4.xlsx")

figfiles <- list.files("figs-web")

figinfofiles <- figureinfo$filename

# expand , separated filenames
figinfofiles2 <- str_split(figinfofiles, pattern= ", ") %>% unlist()

# figinfofiles2 <-
# tidyr::separate_rows(as.data.frame(figinfofiles), sep=", ")

'%!in%' <- function(x,y)!('%in%'(x,y))
figinfofiles2[figinfofiles2 %!in% figfiles]

figfiles[figfiles %!in% figinfofiles2]



expand_commas <- function(fnames) {
  expanded <- ""
browser()
  for (fn in fnames) {
    comma_count = str_count(fn, ",")+1
    if (comma_count > 1) {
      fns = str_trim(
        str_split(fn, ",")[[1]]
      )
    }
    else fns <- fn
    expanded <- c(expanded, fns)   
  }
  expanded
}


figinfofiles2 <-
expand_commas(figinfofiles)

