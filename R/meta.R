library(metathis)
library(dplyr)

meta() %>%
  meta_description(
    "This book provides a comprehensive history of data visualization--its origins, rise, and effects on the ways we think about and solve problems."
  ) %>% 
  meta_name("github-repo" = "friendly/HistDataVis") %>% 
  meta_viewport() %>% 
  meta_social("A History of Data Visualization and Graphic Communication",
    url = "https://friendly.github.io/HistDataVis/",
    image = "https://friendly.github.io/HistDataVis/images/FriendlyWainer-thumb.jpg",
    image_alt = "Cover of the History of Data Visualization book",
    og_type = "book",
    og_author = c("Michael Friendly", "Howard Wainer"),
    twitter_card_type = "summary",
    twitter_creator = "@datavisFriendly"
  ) %>%
  write_meta("meta.html")

