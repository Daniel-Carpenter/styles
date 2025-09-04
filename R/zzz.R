#' @keywords internal
#' @noRd

.onLoad <- function(libname, pkgname) {
  if (!"open_sans" %in% sysfonts::font_families()) {
    sysfonts::font_add_google("Open Sans", "open_sans")
  }
  showtext::showtext_auto()
}
