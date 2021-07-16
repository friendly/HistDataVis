library(glue)
library(readr)

create_figure_chunk = function(image_path, fig_title, fig_desc, fignum) {
  comma_count = str_count(image_path, ",")+1
  
  img_src = ""
  if (comma_count > 1) {
    fnames = str_trim(
      str_split(image_path, ",")[[1]]
    )
    
    for (fn in fnames) {
      final_fn = glue("figs-web/{fn}")
      img_src = str_c(img_src, glue("<img src={single_quote(final_fn)} alt={single_quote(fig_desc)} width=400> \n " ))
    }
  } else {
    final_path = glue("figs-web/{image_path}")
    img_src = glue("<img src={single_quote(final_path)} alt={single_quote(fig_desc)} width=400>")
  }
  
  header = glue("### Figure {fignum}: {fig_title}")
  
  template = glue('<table>
<tr>
<td>\n',
    '{img_src} \n',
    '</td> \n',
    '<td> \n',
    '{header} \n \n',
    '{fig_desc} \n',
    '</td></tr></table> \n'
    )
  
  return(template)
}