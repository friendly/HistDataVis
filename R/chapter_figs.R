# Functions to produce HTML code for all figures in a chapter

# This is designed to be used in a chapter.Rmd file in a chunk,
# ```{r results="asis"} 
# do_chapter(xx)
# ````


library(glue)
library(readr)
library(stringr)
library(rmarkdown)


# file of information about all figures
# NB: now using TOGS-lof5.xlsx, where plates have been made to appear in their chapters.
#     now using TOGS-lof6.xlsx, where some figures have been marked 'DO NOT POST', via `repro=0`

figureinfo <- openxlsx::read.xlsx("figureinfo/TOGS-lof6.xlsx")

# > names(figureinfo)
# [1] "chapter"  "fig"      "fignum"   "repro"    "filename" "title"    "subtitle" "source"  

# constant folder and filenames
image_folder <- "figs-web"                # where the fig live
nono_image   <- "copyright.png"    # image to be used when `repro=0`

figure_chunk = function(image_path, fig_title, fig_desc, fig_source, fignum, width=400) {
  # construct the <img src=> allowing for two or more figure files
  img_src = ""
  comma_count = str_count(image_path, ",")+1
  
  # extract the first sentence in `fig_desc` as the alt string
  # from: https://stackoverflow.com/questions/48884868/extract-first-sentence-in-string
  fig_alt <- str_extract(fig_desc, '.*?[a-z0-9][.?!](?= )')
  fig_alt <- glue("{fig_title}: {fig_alt}")
  
  if (comma_count > 1) {
    fnames = str_trim(
      str_split(image_path, ",")[[1]]
    )
  
  for (fn in fnames) {
    final_fn = glue("{image_folder}/{fn}")
    img_src = str_c(img_src, glue("<img src={single_quote(final_fn)} alt={single_quote(fig_alt)} width={width}> \n " ))
    }
  } else {
    final_path = glue("{image_folder}/{image_path}")
    img_src = glue("<img src={single_quote(final_path)} alt={double_quote(fig_alt)} width={width}>")
  }
  
#  header = glue("#### Figure {fignum}: {fig_title}")
  figtype <- if(str_detect(fignum, "P")) "Plate" else "Figure"
  header = glue("<h3 class='figtitle'>{figtype} {fignum}: {fig_title}</h3>")

  # include figure_source, but as a <span> to allow smaller font size
  fig_src <- glue(
    '<span class="fig-src">',
    '<em>Source:</em> ', {fig_source},
    '</span>'
  )
  
# use glue features to make to output more readable  
  template = glue('
<table class="chap-fig">
  <tr>
    <td width = {width}>
      {img_src}
    </td>
    <td class="chap-fig-desc" width = {width}>
      {header}
      {fig_desc}
      {fig_src}
    </td>
  </tr>
</table>

'
    )
  
  return(template)
}


# Extract figureinfo for a given chapter. Add a formatted figure caption
# This is not currently used, except for the side effect of extracting
# figures for a given chapter.

chapter_figs <- function(ch, fignums) {
	if (missing(fignums))		
		figlist <- figureinfo %>% dplyr::filter(chapter == ch)
	else figlist <- figureinfo %>% filter(fignum %in% fignums)

	figlist$caption <- paste0("<strong>", figlist$title, "</strong> ",
	                          figlist$subtitle)

  # extract figure components for ease of reference
  fignum <- figlist$fignum
  fig_title <- figlist$title
  subtitle <- figlist$subtitle
  source <- figlist$source

  # provide for CSS styling of the components of the figure caption  
	caption <-glue("
<h3 class='figtitle'>Figure {fignum}: {fig_title}</h3>
  <div class='subtitle'>{subtitle}</div>
  <div class='source'>{source}</div>
")	

  #  remove any NAs
	figlist$caption <-gsub("NA", "", caption) 
	figlist
}


# Produce the figures for a given chapter. (This should be re-written using $caption)
# This is designed to be used in a chapter.Rmd file in a chunk,
# ```{r results="asis"} 
# do_chapter(xx)
# ````

# NB: now use `nono_image` if repro==0

do_chapter <- function(ch, thumbwidth=400) {
  figlist <- chapter_figs(ch)

  for (r in 1:nrow(figlist)) {

    filename <- if(figlist[r, "repro"]==0) nono_image else figlist[r, "filename"]
    newchunk = figure_chunk(filename,
                            figlist[r, "title"], 
                            figlist[r, "subtitle"],
                            figlist[r, "source"],
                            figlist[r, "fignum"], width=thumbwidth)
    
    cat(newchunk)
  }

}

