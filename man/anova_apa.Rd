% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/anova_apa.R
\name{anova_apa}
\alias{anova_apa}
\title{Report ANOVA in APA style}
\usage{
anova_apa(
  x,
  effect = NULL,
  sph_corr = c("greenhouse-geisser", "gg", "huynh-feldt", "hf", "none"),
  force_sph_corr = FALSE,
  es = c("petasq", "pes", "getasq", "ges"),
  format = c("text", "markdown", "rmarkdown", "html", "latex", "latex_math", "docx",
    "plotmath"),
  info = FALSE,
  print = TRUE
)
}
\arguments{
\item{x}{A call to \code{aov}, \code{ez::ezANOVA}, or \code{afex::afex_ez},
\code{afex::afex_car} or \code{afex::afex_4}}

\item{effect}{Character string indicating the name of the effect to display.
If is \code{NULL}, all effects are reported (default).}

\item{sph_corr}{Character string indicating the method used for correction if
the assumption of sphericity is violated (only applies to repeated-measures
and mixed design ANOVA). Can be one of \code{"greenhouse-geisser"}
(default), \code{"huynh-feldt"} or \code{"none"} (you may also use the
abbreviations \code{"gg"} or \code{"hf"}).}

\item{force_sph_corr}{Logical indicating if sphericity correction should be
applied to all within factors regardless of what the result of Mauchly's
test of sphericity is (default is \code{FALSE}).}

\item{es}{Character string indicating the effect size to display in the
output, one of \code{"petasq"} (partial eta squared) or \code{"getasq"}
(generalized eta squared) (you may also use the abbreviations \code{"pes"}
or \code{"ges"}).}

\item{format}{Character string specifying the output format. One of
\code{"text"}, \code{"markdown"}, \code{"rmarkdown"}, \code{html},
\code{"latex"}, \code{"latex_math"}, \code{"docx"} or \code{"plotmath"}.}

\item{info}{Logical indicating whether to print a message on the used test
(default is \code{FALSE})}

\item{print}{Logical indicating whether to print the formatted output via
\code{cat} (\code{TRUE}, default) or return as a data frame.}
}
\description{
Report ANOVA in APA style
}
\examples{
# Using the ez package
library(ez)
data(ANT)

x <- ezANOVA(ANT[ANT$error==0,], dv = rt, wid = subnum,
             within = c(cue, flank), between = group, detailed = TRUE)
anova_apa(x)

# Using the afex package
library(afex)
data(md_12.1)

y <- aov_ez(id = "id", dv = "rt", data = md_12.1,
            within = c("angle", "noise"))
anova_apa(y)

}
