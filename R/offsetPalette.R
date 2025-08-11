#' @title Offsets a palette by a number of colors
#' @description This function offsets a palette by a number of colors
#'
#' @param colors A vector of color names
#' @param colorOffset Offsets the ordering of the palette. E.g., colorOffset = 2 would move the first two colors to the end of the palette, starting at the 3rd color.
#'
#' @return The function returns a palette colors
#'
#' @importFrom stats setNames
#' @importFrom utils read.csv
#'
#' @keywords internal


# Create the function
offsetPalette <- function(colors, colorOffset) {
  # Ensure the offset is within the length of the colors
  offset <- colorOffset %% length(colors)

  # If offset is 0, return the original colors
  if (offset == 0) {
    return(colors)
  }

  # Split the colors at the offset point and rearrange
  return(c(colors[(offset + 1):length(colors)], colors[1:offset]))
}
