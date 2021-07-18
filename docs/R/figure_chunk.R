# Modify figure_chunk so that just a single row of figureinfo can be passed
# rather than separate parameters

# Allow to include figure source


#figure_chunk = function(image_path, fig_title, fig_desc, fignum, width=400) {
figure_chunk = function(x, width=400) {
    
  # extract fields from figureinfo row
  image_path <- x$filename
  fig_title <- x$fig_title
  fig_desc <- x$subtitle
  fig_source <- x$source
  fignum <- x$fignum
#  browser()  
  
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
    
  # construct the <img src=> tags for all figures
    for (fn in fnames) {
      final_fn = glue("{image_folder}/{fn}")
      img_src = str_c(img_src, glue("<img src={single_quote(final_fn)} alt={single_quote(fig_alt)} width={width}> \n " ))
    }
  } else {
    final_path = glue("{image_folder}/{image_path}")
    img_src = glue("<img src={single_quote(final_path)} alt={double_quote(fig_alt)} width={width}>")
  }
  
  #  Create header for the figure
  figtype <- if(str_detect(fignum, "P")) "Plate" else "Figure"
  header = glue("<h3 class='figtitle'>{figtype} {fignum}: {fig_title}</h3>")

  # include figure_source, but as a <span> to allow smaller font size
  fig_src <- glue(
    '<span class="fig-src">',
    '<em>Source:</em>', {fig_source},
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

do_chapter <- function(ch, thumbwidth=400) {
  figlist <- chapter_figs(ch)
  
  for (r in 1:nrow(figlist)) {
    
    # newchunk = figure_chunk(figlist[r, "filename"],
    #                         figlist[r, "title"], 
    #                         figlist[r, "subtitle"],
    #                         figlist[r, "fignum"], width=thumbwidth)
    
    newchunk <- figure_chunk(figlist[r,], width = thumbwidth)
    cat(newchunk)
  }
  
}
