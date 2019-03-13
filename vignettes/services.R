## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library("fs")

dir_source <- here::here("man/figures")
dir_target <- here::here("vignettes")
dir_target_figures <- file.path(dir_target, "figures")

if (dir_exists(dir_target_figures)) {
  dir_delete(dir_target_figures)
}

dir_copy(dir_source, dir_target)

## ------------------------------------------------------------------------
library("htmltools")
library("vembedr")

## ------------------------------------------------------------------------
rickroll_youtube(ratio = "4by3") %>%
  use_align("center")

## ------------------------------------------------------------------------
embed_youtube("zpOULjyy-n8") %>%
  use_bs_responsive()

## ------------------------------------------------------------------------
rickroll_youtube() %>%
  use_rounded()

## ------------------------------------------------------------------------
rickroll_youtube() %>%
  use_align("center") %>%
  use_rounded(radius = 5)

## ------------------------------------------------------------------------
embed_youtube("zpOULjyy-n8") %>%
  use_bs_responsive() %>%
  use_rounded()

## ----echo=FALSE----------------------------------------------------------
tags$p(
  tags$code(
    HTML(paste0("https://www.youtube.com/watch?v=", tags$strong("44wDwMQVqCc")))
  )  
)

## ------------------------------------------------------------------------
embed_youtube(id = "44wDwMQVqCc")

## ----echo=FALSE----------------------------------------------------------
tags$p(
  tags$code(
    HTML(paste0("https://vimeo.com/", tags$strong("238200347")))
  )  
)

## ------------------------------------------------------------------------
embed_vimeo(id = "238200347")

## ------------------------------------------------------------------------
embed_url("https://app.box.com/s/m5do45hvzw32iv2aors3urf5pgkxxazx")

## ----eval=FALSE----------------------------------------------------------
#  embed_box(id = "m5do45hvzw32iv2aors3urf5pgkxxazx")

## ----echo=FALSE----------------------------------------------------------
tags$p(
  tags$code(
    HTML(paste0(
      "https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/",  
      tags$strong("Forty-years-of-S")
    ))
  )  
)

## ------------------------------------------------------------------------
embed_user2016(id = "Forty-years-of-S")

## ----echo=FALSE----------------------------------------------------------
tags$p(
  tags$code(
    HTML(paste0(
      "https://channel9.msdn.com/",  
      tags$strong("Shows/Going+Deep/Brian-Beckman-Dont-fear-the-Monads")
    ))
  )  
)

## ------------------------------------------------------------------------
embed_channel9(id = "Shows/Going+Deep/Brian-Beckman-Dont-fear-the-Monads")

## ----eval=FALSE----------------------------------------------------------
#  embed_channel9(
#    id = c("Shows", "Going+Deep", "Brian-Beckman-Dont-fear-the-Monads")
#  )

