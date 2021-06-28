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
# NB: now using TOGS-lof5.xlsx, where plates have been made to appear in their chaperts.
figureinfo <- openxlsx::read.xlsx("figureinfo/TOGS-lof5.xlsx")

# > names(figureinfo)
# [1] "chapter"  "fig"      "fignum"   "filename" "title"    "subtitle" "source" 

image_folder <- "figs-web"

figure_chunk = function(image_path, fig_title, fig_desc, fignum, width=400) {
  
  # construct the <img src=> allowing for two or more figure files
  img_src = ""
  comma_count = str_count(image_path, ",")+1
  if (comma_count > 1) {
    fnames = str_trim(
      str_split(image_path, ",")[[1]]
    )
    
  # extract the first sentence in `fig_desc` as the alt string
  # from: https://stackoverflow.com/questions/48884868/extract-first-sentence-in-string
  fig_alt <- str_extract(fig_desc, '.*?[a-z0-9][.?!](?= )')
  fig_alt <- glue("{fig_title}: {fig_alt}")
  
  for (fn in fnames) {
    final_fn = glue("{image_folder}/{fn}")
    img_src = str_c(img_src, glue("<img src={single_quote(final_fn)} alt={single_quote(fig_alt)} width={width}> \n " ))
    }
  } else {
    final_path = glue("{image_folder}/{image_path}")
    img_src = glue("<img src={single_quote(final_path)} alt={single_quote(fig_alt)} width={width}>")
  }
  
#  header = glue("#### Figure {fignum}: {fig_title}")
  header = glue("<h3 class='figtitle'>Figure {fignum}: {fig_title}</h3>")
  
# use glue features to make to output more readable  
  template = glue('
<table class="chap-fig">
  <tr>
    <td>
      {img_src}
    </td>
    <td class="chap-fig-desc">
      {header}
      {fig_desc}
    </td>
  </tr>
</table>

'
    )
  
  return(template)
}


# extract figureinfo for a given chapter. Add a formatted figure caption

chapter_figs <- function(ch, fignums) {
	if (missing(fignums))		
		figlist <- figureinfo %>% dplyr::filter(chapter == ch)
	else figlist <- figureinfo %>% filter(fignum %in% fignums)

	figlist$caption <- paste0("<strong>", figlist$title, "</strong> ",
	                          figlist$subtitle)

  # extract figure components for ease of reference
  fignum <- figlist$fignum
  title <- figlist$title
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

do_chapter <- function(ch, thumbwidth=400) {
  figlist <- chapter_figs(ch)

  for (r in 1:nrow(figlist)) {

  #TODO re-write figure_chunk to take the call below, using pre-formatted caption
    # newchunk <- figure_chunk(figlist[r, "filename"],
    #                          figlist[r, "caption"], 
    #                          figlist[r, "fignum"], width=thumbwidth)

    newchunk = figure_chunk(figlist[r, "filename"],
                            figlist[r, "title"], 
                            figlist[r, "subtitle"],
                            figlist[r, "fignum"], width=thumbwidth)
    
    cat(newchunk)
  }

}

