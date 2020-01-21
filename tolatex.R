ranking_to_latex <- function(ranking) {
  ranking <- print(rankingsOfErrors_borda)
  ranking <- str_replace_all(ranking, ">", "\\\\succ")
  ranking <- str_replace_all(ranking, "~", "\\\\sim")
  ranking <- paste0("$$", ranking, "$$")
  
  cat(ranking)
  invisible(ranking)
}

ranking_to_latex(rankingsOfErrors_borda)
print(xtable(errors, digits = 3, caption = "Values of each method for the different errors."), row_number = FALSE)

datasets_to_latex <- function() {
  
}
