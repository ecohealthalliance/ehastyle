#!/usr/bin/env Rscript

json_in <- file('stdin', 'r')

lat_newp <- '{"t":"RawBlock","c":["latex","\\\\newpage"]}'

doc_newp <- '{"t":"RawBlock","c":["openxml","<w:p><w:r><w:br w:type=\\"page\\"/></w:r></w:p>"]}'

ast <- paste(readLines(json_in, warn=FALSE), collapse="\n")

ast <- gsub(lat_newp, doc_newp, ast, fixed=TRUE)

write(ast, "")

