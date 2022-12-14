% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/loadStyles.R
\name{theme_dbc}
\alias{theme_dbc}
\title{ggplot2 theme object}
\usage{
theme_dbc()
}
\value{
ggplot theme object
}
\description{
ggplot2 theme object
}
\examples{
library(ggplot2)
library(styles)

# Create basic ggplot object
ggplotObject <- ggplot(mtcars, aes(y=mpg, x=wt, color=as.factor(cyl))) +
    geom_point(size = 3, alpha = 0.5) +
    scale_color_dbc()

# Add the theme
ggplotObject + theme_dbc()
}
