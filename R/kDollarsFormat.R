#' Converts value to scaled format.
#' For example, 10^6 returns "$1 MM" in millions format.
#'
#' @return Formatted number
#'
#' @param x A numeric value or vector.
#' @param scaleUnit Default 'MM', the desired scaling to calculate. Thousands = 'K', Millions = 'M' (or 'MM'), Billions = 'B', Trillions = 'T'.
#' @param useDollarSign Default TRUE if you want to add a dollar sign to the suffix. False to omit '$'.
#' @param roundToDigit Digits to round to after the value has been scaled.
#'
#' @export kDollarsFormat
#'
#' @importFrom scales dollar
#' @importFrom utils stack
#'
#' @examples
#' library(ggplot2)
#' library(styles)
#'
#' kDollarsFormat(1000, scaleUnit = 'K')
#' kDollarsFormat(1000000, scaleUnit = 'M')
#' kDollarsFormat(1000000, scaleUnit = 'MM')
#' kDollarsFormat(1000000000, scaleUnit = 'B')
#' kDollarsFormat(1500000000000, scaleUnit = 'T')
#' kDollarsFormat(1000000, scaleUnit = 'M', useDollarSign = FALSE)
#'
#' # Examples within ggplot
#' df <- mtcars
#' df$mpg <- df$mpg*1000000
#'
#' # Create simple ggplot, no data shown by default
#' gg <- df |>
#'   ggplot(aes(y=mpg, x=wt)) +
#'   theme_dc()
#'
#' # Text labels millions dollars
#' gg + geom_text(aes(label = kDollarsFormat(mpg)))
#'
#' # y-axis format in millions of dollars
#' gg + scale_y_continuous(labels = kDollarsFormat)
#'
#' # y-axis format in *thousands* of dollars
#' gg + scale_y_continuous(labels = ~kDollarsFormat(., scaleUnit = 'K'))
#'
#' # y-axis format with no decimals
#' gg + scale_y_continuous(labels = ~kDollarsFormat(., roundToDigit = 0))
#'
#' # y-axis format with no dollar sign
#' gg + scale_y_continuous(labels = ~kDollarsFormat(., useDollarSign = FALSE))
#'
#' @seealso \code{\link{theme_dc}}
#' @seealso \code{\link{scale_color_dc}}
#' @seealso \code{\link{scale_fill_dc}}



# Create the function
kDollarsFormat <- function(x,
                           scaleUnit     = 'MM',
                           useDollarSign = TRUE,
                           roundToDigit  = 1) {
  # Stop if x is not numeric
  if (!is.numeric(x))
    stop('`x` must be a number.')

  # Override millions to MM format
  if (scaleUnit == 'M')
    scaleUnit = 'MM'

  # List of possible formats
  formatTypes <- list(
    'K'  = 3,
    'M'  = 6,
    # either works as input, but will output 'MM'
    'MM' = 6,
    'B'  = 9,
    'T'  = 12
  )

  # Convert list to data frame
  formatTypesVector <- (formatTypes |> stack())$ind

  # Warn if format not in list
  # Default to million
  if (!(scaleUnit %in% formatTypesVector)) {
    warning(
      paste0(
        'Scale format given (',
        scaleUnit,
        ') not in list: ',
        paste(formatTypesVector, collapse = ', '),
        '. Using "M" as default.'
      )
    )
    scaleUnit = 'M'

  }

  # Get the degree value of the chosen format
  chosenFormatValue <- formatTypes[[scaleUnit]] |> unlist()

  # Round number and scale
  x = round(x / (10^chosenFormatValue), roundToDigit)

  # Create the formatted number
  formattedNumber = dollar(
    x,
    prefix = ifelse(useDollarSign, "$", ''),
    # dollar or not
    suffix = paste0(' ', trimws(scaleUnit))
  )  # K/MM

  return(formattedNumber)
}
