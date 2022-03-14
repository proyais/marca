library(glue)
library(stringr)
library(assertthat)
archivos <- list.files("imagenes", recursive = TRUE, pattern = ".svg$", include.dirs = F)
archivos <- file.path("imagenes", archivos)
assertthat::assert_that(
  !any(str_detect(archivos, "\\s")),
  msg = "Hay archivos o carpetas con espacio en el nombre"
)

build <- function(svg, format, width) {
  cat("\n", "Exportando", svg, "a", format, width, "px", "\n")
  file_name <- str_remove(svg, "\\.svg$")
  file_name <- glue("{ file_name }_w{ width }px.{ format }")
  export_command <- glue("inkscape --export-filename={ file_name } -w { width } { svg }")
  system(export_command, wait = TRUE)
}

resoluciones <- c(2560, 1500, 1000, 500)
formatos <- c("png")

for (nombre_archivo in archivos) {

  for (formato in formatos) {

    for (resolucion in resoluciones) {

      build(nombre_archivo, formato, resolucion)

    }

  }

}
