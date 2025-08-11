#' Format the palette vector based on the use input
#'
#' @param colors       Vector of colors to include retrieve from the palette.
#' @param thePalette   A palette to search on with the colors.
#' @param displayNames TRUE if you want to return a named list with the colors.
#'
#' @return The palette that only includes the subset of colors
#'
#' @keywords internal


# Create the function
subsetAndFormatPalette <- function(colors, thePalette, displayNames) {
  # Return the ENTIRE vector of colors -----------------------------------------
  if (is.null(colors)) {
    # If you need want to see which colors are associated with a hex code
    # Only use this if you just need to know the names
    if (displayNames)
      return(thePalette)

    # Else just return the hex code, this is best for functionality
    else
      return(paste0(thePalette))

    # Return a certain number of colors ----------------------------------------
  } else if (is.numeric(colors)) {
    # If there are more needed colors than the number of colors in the palette
    if (colors > length(thePalette)) {
      warning(
        paste(
          'There are more bins than there are colors.',
          'Considering reducing factor count, or remapping to different color aesthetic.'
        )
      )
    }

    # If you need want to see which colors are associated with a hex code ------
    # Only use this if you just need to know the names
    if (displayNames)
      return(thePalette[1:colors])

    # Else just return the hex code, this is best for functionality ------------
    else
      return(paste0(thePalette[1:colors]))
  }

  # Return a SINGLE color ------------------------------------------------------
  else {
    # If you need want to see which colors are associated with a hex code
    # Only use this if you just need to know the names
    if (displayNames)
      return(thePalette[colors])

    # Else just return the hex code, this is best for functionality
    else
      return(paste0(thePalette[colors]))
  }
}
