## ------------------------------------------------------------------------
library("htmltools")
library("vembedr")

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
    HTML(paste0("https://vimeo.com/", tags$strong("110538136")))
  )  
)

## ------------------------------------------------------------------------
embed_vimeo(id = "110538136")

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

