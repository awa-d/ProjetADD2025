# Packages nécessaires
library(haven)     # Pour lire .sav et gérer labels
library(dplyr)     # Manipulations
library(labelled)  # Gestion des labels variables et valeurs
library(gtsummary) # Tableau descriptif élégant

# 1. Charger la base SPSS
CAM_R10 <- read_sav("C:/Users/hp/Downloads/CAM_R10.Data_11June24.wtd_.final_.release_updated.13Feb25.sav")

# 2. Sélectionner les variables d'intérêt
vars_to_keep <- c("Q98", "Q46PT1", "Q96")
df_sub <- CAM_R10 %>% select(all_of(vars_to_keep))

# 3. Transformer les variables codées en facteurs avec leurs labels de valeurs
df_sub <- df_sub %>%
  mutate(across(everything(), ~as_factor(.)))

# 4. Extraire les labels des variables pour les passer à gtsummary
var_labels <- sapply(df_sub, var_label)
# var_labels est un vecteur nommé : noms variables -> leurs labels

# 5. Créer le tableau résumé avec gtsummary en utilisant ces labels
tbl <- tbl_summary(
  data = df_sub,
  label = as.list(var_labels),
  missing = "no",
  statistic = list(
    all_continuous() ~ "{mean} ({sd})",
    all_categorical() ~ "{n} ({p}%)"
  )
)

# 6. Afficher le tableau
print(tbl)

#install.packages("writexl")
library(writexl)

write_xlsx(df_sub, "df_sub_3vars.xlsx")
cat("Base enregistrée sous df_sub_3vars.xlsx\n")