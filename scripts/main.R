#///////////////////////////////////////////////////////////////////////////////
# PROJECT demoManipulateWidget
#///////////////////////////////////////////////////////////////////////////////
#
#////////
# GOAL:
# Démonstration d'utilitation du package manipulateWidget sur des données 
# Pokemon.
#
#////////
# DATA:
# - Tableau "pokedex" contenant une ligne par pokemon avec les noms, types, 
#   statistique, classement stratégique d'un pokemon.
# - Tableau "resistance" contenant une ligne par pokemon et une colonne par type.
#   Les cases contiennent un indice de résistance allant de -2 à 3: -2 correspond
#   à une forte faiblesses, 3 correspond à une imunité totale.
#
# En plus de ces données deux fonctions sont disponibles:
# - plotPokeStats: prend en argument une ligne de "pokedex" et génère un
#     barchart représentant les statistiques du pokemon correspondant.
# - plotResistance: prend en argument une ligne de "résistance" et crée un
#     barchart représentant les résistances de type d'un pokemon donné.
#
#///////////////////////////////////////////////////////////////////////////////

prStart()
View(pokedex)
View(resistance)

plotPokeStats(pokedex[1, ])
plotResistance(resistance[1, ])

# Composition de graphiques ####################################################



# Création d'une interface graphique ###########################################



# Exemple plus conséquent ######################################################

prScript("partenaireIdeal")
