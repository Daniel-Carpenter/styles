#' @title Get Palette from CSV Files in Directory
#' @description This function reads palette data from CSV files located in a specified directory
#'
#' @param aesthetic The name of the aesthetic
#' @param colors A vector of color names
#' @param colorOffset Offsets the ordering of the palette. E.g., colorOffset = 2 would move the first two colors to the end of the palette, starting at the 3rd color.
#' @param reverseOrder Logical, TRUE reverses the default order of the palette. Default FALSE. Applied after colorOffset.
#' @param darkenPaletteForTextGeoms Logical, if TRUE then the palette will be darkened  slightly
#' @param displayNames Logical, if TRUE display names of the colors
#' @param useColorBlindPalette Logical, if TRUE uses color blind friendly palette instead of style.
#' @param colorBlindPaletteName Name of colorblind friendly palette. Use `cols4all::c4a_palettes()` for available palettes.
#' @param fileSuffix A suffix to be added to the file name (default: "-colors")
#' @param fileExtension The extension of the file (default: ".csv")
#' @param directoryOfPalette The directory of the palette data (default: "extdata")
#' @param thisPackageName The name of the package (default: "styles")
#'
#' @return The function returns a named list representing a color palette
#'
#' @importFrom stats setNames
#' @importFrom utils read.csv
#' @importFrom cols4all c4a
#' @importFrom colorspace darken lighten
#'
#' @keywords internal



# Create the function
getPalette <- function(aesthetic,
                       colors,
                       colorOffset        = 0,
                       reverseOrder       = FALSE,
                       displayNames       = FALSE,
                       darkenPaletteForTextGeoms = FALSE,
                       useColorBlindPalette = FALSE,
                       colorBlindPaletteName = 'safe',
                       fileSuffix         = "-colors",
                       fileExtension      = '.csv',
                       directoryOfPalette = "extdata",
                       thisPackageName    = "styles") {
  # Intensity to darken text
  DARKEN_AMOUNT = 0.4
  LIGHTEN_AMOUNT_FILL = 0.6

  # If using brand palette
  if (!(useColorBlindPalette)) {
    ## Get the path of the palette
    filename = paste0(aesthetic, fileSuffix, fileExtension)
    filePathOfPalette <- system.file(directoryOfPalette, filename, package = thisPackageName)


    ## Read the palette in
    thePalette_base <- as.list(read.csv(filePathOfPalette))

    ## Convert to a named list
    thePalette <- setNames(thePalette_base$hexCode, thePalette_base$color)

    # Using Color blind palette
  } else {
    # Get color blind palette.
    thePalette <- c4a(palette = colorBlindPaletteName)

    # Lighten the palette if using fill palette
    if (aesthetic == 'fill') {
      thePalette <- lighten(thePalette, LIGHTEN_AMOUNT_FILL)
    }
  }

  # Offset the palette if user specifies
  thePalette <- offsetPalette(thePalette, colorOffset = colorOffset)

  # Reverse order if user specifies
  if (reverseOrder) {
    thePalette <- rev(thePalette)
  }

  # Darken the palette by a set intensity for overlaying text on charts
  if (darkenPaletteForTextGeoms & aesthetic == 'color') {
    thePalette <- darken(thePalette, amount = DARKEN_AMOUNT)

    # Warn the user if they try to darken a palette that is not the color aesthetic
  } else if (darkenPaletteForTextGeoms & aesthetic != 'color') {
    warning(
      'Palette not darkened. Due to branding restriction, only darken the `color` aesthetic for text geoms. Fill aesthetic should not be darkened.'
    )
  }

  return(subsetAndFormatPalette(colors, thePalette, displayNames))
}



# #' @examples
# #' thePalette <- readPaletteData(aesthetic  = "accent-colors.csv",
# #'                               directoryOfPalette = "extdata",
# #'                               thisPackageName    = "styles"
# #'                               )
# #' # Print the palette
# #' thePalette
# #'
# #' # Look at the blue color
# #' thePalette[['blue']]#
