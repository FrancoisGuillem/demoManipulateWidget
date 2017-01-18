#///////////////////////////////////////////////////////////////////////////////
# FUNCTION PlotPokemon
#///////////////////////////////////////////////////////////////////////////////
#
#////////
# DESCRIPTION:
# Graphique interactif permettant de visualiser les forces et faiblesses
# d'un pokemon. 
#
#////////
# ARGS:
# - pkName: nom du pokemon
#
#////////
# RETURNS:
# un htmlwidget de class combinedWidget.
#
#////////
# EXAMPLES:
# plotPokemon("Ivysaure")
#
#///////////////////////////////////////////////////////////////////////////////

plotPokemon <- function(pkName) {
  if (length(pkName) == 0 || pkName == "") return(combineWidgets())
  
  pokemon <- pokedex %>% filter(name == pkName)
  resist <- resistance %>% filter(name == pkName)
  type <- paste(pokemon$type1, 
                ifelse(is.na(pokemon$type2), "", pokemon$type2))
  
  type <- sprintf("<span style='color:%s;'>%s</span>", 
                  typeColors[pokemon$type1], pokemon$type1)
  
  if (!is.na(pokemon$type2)) {
    type <- paste(type, sprintf("/ <span style='color:%s;'>%s</span>", 
                                typeColors[pokemon$type2], pokemon$type2))
  }
  
  title <- sprintf("%s (%s)", pokemon$nameFR, type)
  
  combineWidgets(
    plotPokeStats(pokemon),
    plotResistance(resist),
    ncol = 2,
    title = title,
    rightCol = tags$div(
      style = "width:150px",
      tags$a(
        href = pokemon$urlPokestrat,
        staticImage(sprintf("data/animations/%s.gif", pkName), 
                    style = "position:absolute;bottom:30px;")
      )
    )
  )
}



