sapply(1:length(lista_numerical), function(x) {print(xtable(clean_tabla(inordernum[[x]]), digits = 4, caption = names(inordernum)[x]), include.rownames = F, caption.placement = 'top')})

# Para pasar cada fila a linea latex
str_replace("fila", ".*", "$$.*$$")