#' Report Correlation in APA style
#'
#' @param x A call to \code{cor.test}
#' @param r_ci Logical indicating whether to display the confidence interval
#'   for the correlation coefficient (default is \code{FALSE}). Only available
#'   for Pearson's product moment correlation (with n >= 4).
#' @param format Character string specifying the output format. One of
#'   \code{"text"}, \code{"markdown"}, \code{"rmarkdown"}, \code{html},
#'   \code{"latex"}, \code{"latex_math"}, \code{"docx"} or \code{"plotmath"}.
#' @param info Logical indicating whether to print a message on the used test
#'   (default is \code{FALSE})
#' @param print Logical indicating whether to print the formatted output via
#'   \code{cat} (\code{TRUE}, default) or return as character string.
#' @examples
#' # Example data from ?cor.test
#' x <- c(44.4, 45.9, 41.9, 53.3, 44.7, 44.1, 50.7, 45.2, 60.1)
#' y <- c( 2.6,  3.1,  2.5,  5.0,  3.6,  4.0,  5.2,  2.8,  3.8)
#'
#' cor_apa(cor.test(x, y))
#'
#' # Spearman's rho
#' cor_apa(cor.test(x, y, method = "spearman"))
#'
#' # Kendall's tau
#' cor_apa(cor.test(x, y, method = "kendall"))
#'
#' @export
cor_apa <- function(x, r_ci = FALSE,
                    format = c("text", "markdown", "rmarkdown", "html", "latex",
                               "latex_math", "docx", "plotmath"),
                    info = FALSE, print = TRUE)
{
  format <- match.arg(format)

  # Make sure that 'x' was a call to `cor.test`
  if (!inherits(x, "htest") && !grepl("correlation", x$method))
  {
    stop("'x' must be a call to `cor.test`")
  }

  if (format == "docx")
  {
    return(apa_to_docx("cor_apa", x))
  }

  # Extract and format test statistics
  coef <- tolower(strsplit(x$method, " ")[[1]][1])
  estimate <- fmt_stat(x$estimate, leading_zero = FALSE)
  df <- x$parameter
  p <- fmt_pval(x$p.value)

  if (r_ci)
  {
    if (is.null(x$conf.int))
    {
      warning(paste("Confidence interval only available for Pearson's product",
                    "moment correlation (with n >= 4)"))

      r_ci <- FALSE
    }
    else
    {
      ci <- fmt_stat(x$conf.int, leading_zero = FALSE, equal_sign = FALSE)
    }
  }

  if (info) message(x$method)

  # Put the formatted string together
  text <- paste0(
    fmt_symb(coef, format),
    if (coef == "pearson's") paste0("(", df, ") ") else " ", estimate,
    if (r_ci) paste0(" [", ci[1], "; ", ci[2], "]"), ", ",
    fmt_symb("p", format), " ", p)

  # Further formatting for LaTeX and plotmath
  if (format == "latex")
  {
    text <- fmt_latex(text)
  }
  else if (format == "latex_math")
  {
    text <- fmt_latex_math(text)
  }
  else if (format == "plotmath")
  {
    # Convert text to an expression
    text <- fmt_plotmath(text, "(\\([0-9]+\\))", "( [<=] -?\\.[0-9]{2}, )",
                         "( [<=>] \\.[0-9]{3})")

    # Text is an expression, so we can't use `cat` to print it to the console
    print <- FALSE
  }

  if (print) cat(text) else text
}
