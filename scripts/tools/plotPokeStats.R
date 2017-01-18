#///////////////////////////////////////////////////////////////////////////////
# FUNCTION PlotPokeStats
#///////////////////////////////////////////////////////////////////////////////
#
#////////
# DESCRIPTION:
# Graphique interactif représentant les statistiques d'un pokémon sous forme
# de barchart. Le graphique affiche les valeurs jusqu'à 150. Au delà la barre
# est tronquée et a une couleur différente.
#
#////////
# ARGS:
# - pokemon: une ligne du tableau "pokedex"
#
#////////
# RETURNS:
# - htmlwidget de classe plotly
#
#////////
# EXAMPLES:
# pokemon <- pokedex %>% filter(name == "Venusaur")
# plotPokeStats(pokemon)
#
#///////////////////////////////////////////////////////////////////////////////

plotPokeStats <- function(pokemon) {
  statNames <- c("HP", "attack", "defense", "spAttack", "spDefense", "speed")
  stats <- unlist(pokemon[, statNames])
  plot_ly() %>% config(displayModeBar = FALSE) %>% 
    add_bars(
      y = stats, 
      x = statNames, 
      alpha =0.8, 
      color = factor(stats > 151, levels = c("FALSE", "TRUE")),
      colors = c("#CCCCFF", "#FFD700"),
      hoverinfo = "y"
    ) %>% 
    layout(
      showlegend = FALSE,
      yaxis = list(range = list(0, 152)),
      xaxis = list(categoryarray = statNames, categoryorder = "array")
    )
}



