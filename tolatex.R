ranking_to_latex <- function(ranking) {
  ranking <- print(rankingsOfErrors_borda)
  ranking <- str_replace_all(ranking, ">", "\\\\succ")
  ranking <- str_replace_all(ranking, "~", "\\\\sim")
  ranking <- paste0("$$", ranking, "$$")
  
  cat(ranking)
  invisible(0)
}

ranking_to_latex(rankingsOfErrors_borda)
print(xtable(errors, digits = 3, caption = "Points of the dataset"), row_number = FALSE)
