#///////////////////////////////////////////////////////////////////////////////
# SCRIPT partenaireIdeal
#///////////////////////////////////////////////////////////////////////////////
#
#////////
# GOAL:
# Trouver le partenaire idéal pour un pokemon (ou plusieurs pokemon ?).
#
#////////
# APPROACH:
# Le partenaire idéal est un pokemon avec de bonnes statistiques d'une part
# et qui a des forces et faiblesses complémentaires. On calcule trois scores:
# - score basés sur les statistiques (on commence avec la somme)
# - distance entre les statistiques des deux pokémons
# - distance entre les faiblesses de type des deux pokémons
# 
# Une fois ce travail réalisé, on utilise le produit des trois scores pour
# avoir un score de "partenariat".
#
#////////
# DATA:
# Tableaux "pokedex" et "resistance". On ne conserve que les pokemon totalement
# évolués
#
#////////
# RESULTS:
# what were the results of the analysis ?
#
#///////////////////////////////////////////////////////////////////////////////

prLoad("pokedex")
prLoad("resistance")
# Ne conserver que les pokemons qui ont fini d'évoluer
pokedex %<>% filter(lastEvo == TRUE) %>% arrange(name)
resistance %<>% filter(name %in% pokedex$name) %>% arrange(name)

# Précalcul des scores intermédiaires ##########################################

# Somme des statistiques
scoreStats <- pokedex %>% 
  mutate(scoreStat = HP + pmax(attack, spAttack) * 2 + defense + spDefense + speed) %>% 
  select(name, scoreStat)

# Distance des statistiques
distStats <- pokedex %>% 
  select(HP, attack, defense, spAttack, spDefense, speed) %>% 
  dist(method = "manhattan") %>% as.matrix() %>% 
  set_colnames(pokedex$name) %>% 
  set_rownames(pokedex$name)

# Distance des faiblesses
myDistFun <- function(x, y) {
  maxRes <- pmax(x, y)
  commonWeaknesses <- maxRes[maxRes < 0]
  sum(maxRes) + 100 * sum(commonWeaknesses)
}

distResistance <- resistance %>% 
  select(-name) %>% 
  proxy::dist(., method = myDistFun) %>% as.matrix() %>% 
  set_colnames(resistance$name) %>% 
  set_rownames(resistance$name)


# Score de partenariat #########################################################

# Fonction qui prend en entrée le nom d'un pokémon et qui renvoie un tableau
# avec une ligne par pokemon, le score obtenu et le rang du pokemon selon ce score
partnershipScore <- function(pkName, coefs) {
  scoreStats %>% 
    mutate(
      score = scoreStat^coefs[1] * distStats[, pkName]^coefs[2] * 
        distResistance[pkName, ]^coefs[3],
      rank = rank(-score)
    ) %>% 
    select(-scoreStat) %>% 
    arrange(rank)
}

# Graphique interactif #########################################################

plotPartnershipScore <- function(pkName, coefs, rank, tiers = NULL) {
  if (length(pkName) == 0 || pkName == "") return(combineWidgets())
  
  score <- partnershipScore(pkName, coefs)
  
  if (length(tiers) > 0) {
    pokemonInTiers <- pokedex %>% filter(tier %in% tiers)
    score %<>% 
      filter(name %in% pokemonInTiers$name) %>% 
      mutate(rank = rank(score))
  }
  
  partner <- score[rank, "name"]
  
  combineWidgets(
    plotPokemon(pkName),
    plotPokemon(partner)
  )
}

pokemonList <- pokedex$name
names(pokemonList) <- pokedex$nameFR

manipulateWidget(
  plotPartnershipScore(name, c(coef1, coef2, coef3), rank, tiers),
  name = mwSelect(pokemonList, label = "Pokemon"),
  rank = mwSlider(1, nrow(pokedex), 1, step = 1, label = "Rang score de partenariat"),
  coef1 = mwNumeric(1, "Coef Stats"),
  coef2 = mwNumeric(1, "Coef diff stats"),
  coef3 = mwNumeric(1, "Coef diff types"),
  tiers = mwSelect(unique(pokedex$tier), multiple = TRUE),
  .updateInputs = list(
    rank = list(max = ifelse(length(tiers) > 0, sum(pokedex$tier %in% tiers), nrow(pokedex)))
  )
)
