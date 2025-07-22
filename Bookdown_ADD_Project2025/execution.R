# Installer bookdown si nécessaire
install.packages("bookdown")

bookdown::render_book("index.Rmd", "bookdown::gitbook")
