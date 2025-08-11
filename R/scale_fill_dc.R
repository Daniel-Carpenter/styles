#' ggplot Fill Scale
#'
#' @return ggplot fill scale
#'
#' @param overrideWithAccent TRUE if you want to use the color palette for the fill mapping. (Default FALSE)
#' @param colorOffset Offsets the ordering of the palette. E.g., colorOffset = 2 would move the first two colors to the end of the palette, starting at the 3rd color.
#' @param reverseOrder Logical, TRUE reverses the default order of the palette. Default FALSE. Applied after colorOffset.
#' @param useColorBlindPalette Logical, if TRUE uses color blind friendly palette instead of style.
#' @param colorBlindPaletteName Name of colorblind friendly palette. Use `cols4all::c4a_palettes()` for available palettes.
#' @param ... Additional parameters passed to either scale_color_manual or scale_fill_manual functions, such as guide = 'none'
#'
#' @export scale_fill_dc
#'
#' @importFrom ggplot2 scale_fill_manual
#'
#' @examples
#' library(ggplot2)
#' library(styles)
#'
#' # Create basic ggplot object
#' ggplotObject <- ggplot(mtcars, aes(y=mpg, x=as.factor(cyl), fill=as.factor(cyl))) +
#'
#'     # Note that gray border used for demonstration. Please use scale_color_dc()
#'     # as much as possible
#'     geom_boxplot(size = 0.8, color = scale_dc('gray', 'gray3'))
#'
#' # Add the fill color
#' ggplotObject + scale_fill_dc()
#'
#' # Add the accent color
#' ggplotObject + scale_fill_dc(overrideWithAccent = TRUE)
#'
#' # Add the fill color and turn off legend with optional parameter
#' ggplotObject + scale_fill_dc(guide = 'none')
#'
#' # Offset the colors by 1
#' ggplotObject + scale_fill_dc(colorOffset = 1)
#'
#' # reverse the order of the palette
#' ggplotObject + scale_fill_dc(reverseOrder = TRUE)
#'
#' # Use color blind palette
#' ggplotObject + scale_fill_dc(useColorBlindPalette = TRUE)
#'
#' @seealso \code{\link{theme_dc}}
#' @seealso \code{\link{scale_dc}}
#' @seealso \code{\link{scale_color_dc}}



# Create the function
scale_fill_dc <- function(overrideWithAccent = FALSE,
                            colorOffset        = 0,
                            reverseOrder       = FALSE,
                            useColorBlindPalette  = FALSE,
                            colorBlindPaletteName = 'safe',
                            ...
                            )  {

  # Use fill color by default
  if ( !(overrideWithAccent) ) {
    return( scale_fill_manual(values = scale_dc('fill',
                                                  colorOffset           = colorOffset,
                                                  reverseOrder          = reverseOrder,
                                                  useColorBlindPalette  = useColorBlindPalette,
                                                  colorBlindPaletteName = colorBlindPaletteName
                                                  ),
                              ...) )
  }

  # If you would rather use the accent color, then return that
  else {
    return( scale_fill_manual(values = scale_dc('color',
                                                  colorOffset           = colorOffset,
                                                  reverseOrder          = reverseOrder,
                                                  useColorBlindPalette  = useColorBlindPalette,
                                                  colorBlindPaletteName = colorBlindPaletteName
                                                  ),
                              ...) )
  }
}
