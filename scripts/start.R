#///////////////////////////////////////////////////////////////////////////////
# SCRIPT start
#///////////////////////////////////////////////////////////////////////////////

prLibrary("magrittr", "dplyr", "tidyr", "plotly", "manipulateWidget", "shiny", 
          "proxy")

sortedTypes <- c("normal", "feu", "eau", "plante", "electrik", "glace", 
                 "combat", "poison", "sol", "vol", "psy", "insecte",
                 "roche", "spectre", "dragon", "tenebre", "acier", "fee")

typeColors <- c(
  normal = "#A8A878", 
  feu = "#F08030", 
  eau = "#6890F0", 
  plante = "#78C850", 
  electrik = "#F8D030", 
  glace = "#98D8D8",
  combat = "#C03028", 
  poison = "#A040A0", 
  sol = "#E0C068", 
  vol = "#A890F0", 
  psy = "#F85888", 
  insecte = "#A8B820",
  roche = "#B8A038", 
  spectre = "#705898", 
  dragon = "#7038F8", 
  tenebre = "#705848", 
  acier = "#B8B8D0", 
  fee = "#EE99AC"
)

prLoad("pokedex")
prLoad("resistance")
