# ==============================================================================
# Goal: Streamline personal colors aesthetic usage
# ==============================================================================

# Install ggplot2 since you will be using it
if(!require(ggplot2)) install.packages('ggplot2'); library(ggplot2)


#' Function that returns palettes or individual colors
#' This is done separately just to reduce noise in the file
#' Mainly, this just either displays the names of the colors or not when returing
#' It also allows you to return 1 or all of the colors
#' @param displayNames TRUE if you want to see the names of each color. Default FALSE.
#' @param aesthetic Color aesthetic in 'fill', 'color', 'base', 'text','border','background', or 'grayedOut'
#' @param ... single or vector of colors
#'
#' @return hex codes for color palettes
#' @export scale_dbc
#'
#' @examples
#' library(styles)
#'
#' # Single valued colors: Basic elements
#' scale_dbc('text')       # Text (dark gray)
#' scale_dbc('background') # Background (white)
#' scale_dbc('border')     # Border (light gray)
#' scale_dbc('grayedOut')  # (Very light gray)
#'
#' # Palettes: Used in scale fill or scale color below
#' scale_dbc('color', displayNames = TRUE) # All colors
#' scale_dbc('fill',  displayNames = TRUE) # All fills
#' scale_dbc('fill', 3)                    # 3 fills
#' scale_dbc('fill', 'blue', displayNames = TRUE) # Just blue
scale_dbc <- function(aesthetic = NULL, ..., displayNames = FALSE) {

  formatReturnColors <- function(colors, thePalette, displayNames) {

    # Return the ENTIRE vector of colors
    if (is.null(colors)) {

      # If you need want to see which colors are associated with a hex code
      # Only use this if you just need to know the names
      if (displayNames)
        return (thePalette)

      # Else just return the hex code, this is best for functionality
      else
        return (paste0(thePalette))

    # Return a certain number of colors
    } else if (is.numeric(colors)) {

      # If there are more needed colors than the number of colors in the palette
      if (colors > length(thePalette)) {
        warning(paste('There are more bins than there are colors.',
                      'Considering reducing factor count, or remapping to different color aesthetic.')
        )
      }
      # If you need want to see which colors are associated with a hex code
      # Only use this if you just need to know the names
      if (displayNames)
        return (thePalette[1:colors])

      # Else just return the hex code, this is best for functionality
      else
        return (paste0(thePalette[1:colors]))
    }

    # Return a SINGLE color
    else {

      # If you need want to see which colors are associated with a hex code
      # Only use this if you just need to know the names
      if (displayNames)
        return (thePalette[colors])

      # Else just return the hex code, this is best for functionality
      else
        return (paste0(thePalette[colors]))
    }
  }


  # Line Colors ------------------------------------------------------------------

  # For example, the lines (or accents) on a chart. These are just a bit darker than the fills

  # Function to retreive all, some, or one line color
  # Default returns the entire list of line colors
  getLineCol <- function(..., displayNames = FALSE) {
    colors <- c(...) # get colors from function params

    # Define the line colors
    # https://davidmathlogic.com/colorblind/#%236388B4-%23E68900-%23EB4B43-%2354AC88-%23B07AA1-%233C9DAA-%23C5A952-%238A807E-%23D16D91-%23945430
    linePalette <- c(
      'blue'   = '#6388B4',
      'orange' = '#E68900',
      'red'    = '#EB4B43',
      'green'  = '#54AC88',
      'purple' = '#B07AA1',
      'blue1'  = '#3C9DAA',
      'yellow' = '#C5A952',
      'grey'   = '#8A807E',
      'pink'   = '#D16D91',
      'tan'    = '#945430'
    )

    # Based on inputs, return one or all colors, either displaying the names or not
    return ( formatReturnColors(colors, linePalette, displayNames) )
  }


  # Fill Colors ----------------------------------------------------------------

  # For example, the fill colors on a bar chart. These are displayed in the style guide

  # Function to retrieve all, some, or one fill color
  # Default returns the entire list of fill colors
  # https://davidmathlogic.com/colorblind/#%23BECDE0-%23FFD597-%23F6B7B4-%23BEE0D2-%23E4C6DC-%23BDDBE1-%23F7E5B3-%23DCDADA-%23FCC8DA-%23E5CFC5
  getFillCol <- function(..., displayNames = FALSE) {
    colors <- c(...) # get colors from function params

    # Define the fill colors
    fillPalette <- c(
      'blue'   = '#BECDE0',
      'orange' = '#FFD597',
      'red'    = '#F6B7B4',
      'green'  = '#BEE0D2',
      'purple' = '#E4C6DC',
      'blue1'  = '#BDDBE1',
      'yellow' = '#F7E5B3',
      'grey'   = '#DCDADA',
      'pink'   = '#FCC8DA',
      'tan'    = '#E5CFC5'
    )

    # Based on inputs, return one or all colors, either displaying the names or not
    return ( formatReturnColors(colors, fillPalette, displayNames) )
  }


  # Base Colors ------------------------------------------------------------------

  # For example, this would be the navy backgrounds on the slide decks

  # Function to retrieve all, some, or one base color
  # Default returns the entire list of base colors
  getBaseCol <- function(..., displayNames = FALSE) {
    colors <- c(...) # get colors from function params

    # Define the line colors
    basePalette <- c('navy'  = '#3F4953',
                     'navy1' = '#394149',
                     'navy2' = '#2D343B')

    # Based on inputs, return one or all colors, either displaying the names or not
    return ( formatReturnColors(colors, basePalette, displayNames) )
  }


  # Other Colors -----------------------------------------------------------------

  getTextCol       <- function() { return('#585858') } # Text Color
  getBorderCol     <- function() { return('#E6E6E6') } # Border Color
  getBackgroundCol <- function() { return('#FAFAFA') } # Background Color
  getGrayedOutCol  <- function() { return('grey87' ) } # COnsistent Grey for graying out objects


  # RETURN A PALETTE -------------------------------------------------------------

  # Options for palettes:
  paletteOptions <- c('fill', 'color', 'base',
                      'text','border','background','grayedOut')

  # If no aesthetic given
  if ( is.null(aesthetic) ) {
    warning(paste('You need to define a `aesthetic`, e.g. `aesthetic = "fill"`. Use from this list:\n ',
                  toString(paletteOptions) ) )

  # If NOT given a credible aesthetic
  } else if ( !(aesthetic %in% paletteOptions) ) {
    warning(paste('Incorect aesthetic type. Choose from:', toString(paletteOptions) ) )

  # Else, you are given a credible aesthetic
  } else {

    # If wanting fill aesthetic
    if (aesthetic == paletteOptions[1]) { return(getFillCol(..., displayNames=displayNames)) }

    # If wanting line aesthetic
    if (aesthetic == paletteOptions[2]) { return(getLineCol(..., displayNames=displayNames)) }

    # If wanting base aesthetic
    if (aesthetic == paletteOptions[3]) { return(getBaseCol(..., displayNames=displayNames)) }

    # The single values color return functions:
    if (aesthetic == paletteOptions[4]) { return(getTextCol()) }
    if (aesthetic == paletteOptions[5]) { return(getBorderCol()) }
    if (aesthetic == paletteOptions[6]) { return(getBackgroundCol()) }
    if (aesthetic == paletteOptions[7]) { return(getGrayedOutCol()) }
  }
}

# ggplot2 Scale Functions ------------------------------------------------------


#' ggplot Color Scale
#'
#' @return ggplot color scale
#' @export scale_color_dbc
#'
#' @examples
#' library(ggplot2)
#' library(styles)
#'
#' # Create basic ggplot object
#' ggplotObject <- ggplot(mtcars, aes(y=mpg, x=wt, color=as.factor(cyl))) +
#'     geom_point(size = 3, alpha = 0.5)
#'
#' # Add the color
#' ggplotObject + scale_color_dbc()
scale_color_dbc <- function()  {
  scale_color_manual(values = scale_dbc('color'))
}

#' ggplot Fill Scale
#'
#' @return ggplot fill scale
#' @export scale_fill_dbc
#'
#' @examples
#' library(ggplot2)
#' library(styles)
#'
#' # Create basic ggplot object
#' ggplotObject <- ggplot(mtcars, aes(y=mpg, x=wt, fill=as.factor(cyl))) +
#'     geom_point(size = 3, alpha = 0.5)
#'
#' # Add the fill color
#' ggplotObject + scale_fill_dbc()
scale_fill_dbc <- function()  {
  scale_fill_manual(values = scale_dbc('fill'))
}

# ggplot Theme -----------------------------------------------------------------


#' ggplot2 theme object
#'
#' @return ggplot theme object
#' @export theme_dbc
#'
#' @examples
#' library(ggplot2)
#' library(styles)
#'
#' # Create basic ggplot object
#' ggplotObject <- ggplot(mtcars, aes(y=mpg, x=wt, color=as.factor(cyl))) +
#'     geom_point(size = 3, alpha = 0.5) +
#'     scale_color_dbc()
#'
#'# Add the theme
#' ggplotObject + theme_dbc()
theme_dbc <- function() {

  textCol   = scale_dbc('text')
  borderCol = scale_dbc('border')

  dbcTheme <- theme(

    # All Font  Size
    text                = element_text(size  = 11),

    # Panel
    panel.background    = element_rect(fill     = 'white',
                                       color    = 'white'),
    panel.border        = element_rect(fill     = NA,
                                       color    = borderCol),
    panel.grid.major.x  = element_blank(),
    panel.grid.major.y  = element_line(linetype = "solid",
                                       color    = "grey95",
                                       size     = 0.2),

    # Main Title
    plot.title          = element_text(color  = textCol,
                                       size   = 16,
                                       hjust  = 0),
    plot.subtitle       = element_text(color  = textCol,
                                       size   = 13,
                                       hjust  = 0),

    # Axis Titles
    axis.text           = element_text(color  = textCol,
                                       size   = 11),
    axis.title          = element_text(color  = textCol,
                                       size   = 12),

    # Facet Titles
    strip.text          = element_text(color  = textCol,
                                       size   = 12),
    strip.background    = element_rect(fill   = "#EAEAEA",
                                       color  = borderCol,
                                       size   = 0.40),

    # Caption Font
    plot.caption        = element_text(color  = textCol,
                                       size   = 8.5,
                                       hjust  = 1),

    # Legend
    legend.background   = element_rect(fill   = "grey99",
                                       color  = "grey85",
                                       size   = 0.40),
    legend.text         = element_text(color  = textCol),
    legend.position     = "top",
    legend.title        = element_blank(),

    # Margin
    plot.margin         = margin(t = 15,
                                 b = 30,
                                 r = 30,
                                 l = 30,
                                 unit = "pt")
  )

  # Set Theme Active - Use `theme_get()` when using ggplot
  theme_set(dbcTheme)

  return(dbcTheme)
}
