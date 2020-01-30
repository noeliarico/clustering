results_info <- tribble(~name, ~ranking)
lines <- read_lines("results.txt")

ranking_to_latex <- function(ranking) {
  ranking <- capture.output(print(rankingsOfErrors_borda))
  ranking <- str_replace_all(ranking, ">", "\\\\succ")
  ranking <- str_replace_all(ranking, "~", "\\\\sim")
  ranking <- paste0("$$", ranking, "$$")
  
  return(ranking)
}

for(line in lines) {

  if(str_detect(line, "data")) {
    name <- str_remove(line, "\\$data_")
  } else {
    #ranking <- ranking_to_latex(line)
    ranking <- line
    results_info <- results_info %>% add_row(name, ranking)
  }

  
}
library(xtable)
print(xtable(results_info, caption = "Results."), include.rownames = FALSE)
