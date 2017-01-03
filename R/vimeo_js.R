#' This does not work - yet!
use_vimeo_js <- function(){

  htmltools::tagList(
    htmltools::tags$script(src="https://player.vimeo.com/api/player.js"),
    htmltools::tags$script("

      var embeds = $('.vimeo-embed');

      console.log(embeds)

      for (var i = 0; i !== embeds.length; i++) {

        var player = new Vimeo.Player(embeds[i]);

        player.ready().then(function() {
          player.pause();
        });

      };

      ")
  )


}
