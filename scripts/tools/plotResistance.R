#///////////////////////////////////////////////////////////////////////////////
# FUNCTION PlotResistance
#///////////////////////////////////////////////////////////////////////////////
#
#////////
# DESCRIPTION:
# Graphique interactif représentant les résistances et faiblesses de type d'un
# pokemon donnée sous forme de barchart.
#
#////////
# ARGS:
# - resistance: ligne du tableau "resistance" correspondant à un pokemon donné.
#
#////////
# RETURNS:
# htmlwidget de classe "plotly"
#
#////////
# EXAMPLES:
# pokemonResist <- resistance %>% filter(name == "Venusaur")
# plotResistance(pokemonResist)
#
#///////////////////////////////////////////////////////////////////////////////

plotResistance <- function(resistance) {
  resistance %<>% 
    select(-name) %>% 
    gather("type", "resist")
  
  plot_ly(resistance) %>% config(displayModeBar = FALSE) %>% 
    add_bars(x = ~type, y = ~resist, color = ~type, hoverinfo = "x", colors = typeColors) %>% 
    layout(
      margin = list(b = 30, l = 0),
      showlegend = FALSE, 
      xaxis = list(categoryarray = ~type, categoryorder = "array", title = "", showticklabels = FALSE),
      yaxis = list(range = c(-2.2, 3.2), title = "", showticklabels = FALSE)
    )
}



