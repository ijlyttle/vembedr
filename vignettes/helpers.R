## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library("htmltools")
library("vembedr")

## -----------------------------------------------------------------------------
embed_youtube(id = "8SGif63VW6E") %>% 
  use_start_time("4m12s")

## -----------------------------------------------------------------------------
embed_url("https://www.youtube.com/watch?v=q2nNzNo_Xps")

## -----------------------------------------------------------------------------
suggest_embed("https://www.youtube.com/watch?v=1-vcErOPofQ")

## -----------------------------------------------------------------------------
suggest_embed("https://youtu.be/1-vcErOPofQ?t=28s")

## -----------------------------------------------------------------------------
suggest_embed("https://vimeo.com/131407894")

## -----------------------------------------------------------------------------
suggest_embed("https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/Day-3-Siepr-130-Ligtning-Talks-100-PM-140-PM?ocid=player")

## -----------------------------------------------------------------------------
suggest_embed("https://channel9.msdn.com/Shows/Going+Deep/Brian-Beckman-Dont-fear-the-Monads")

## -----------------------------------------------------------------------------
rickroll_youtube()

## -----------------------------------------------------------------------------
rickroll_vimeo()

## -----------------------------------------------------------------------------
rickroll_channel9()

