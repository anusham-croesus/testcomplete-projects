-- Modifier l'ancien paramètre dans B_CONFIG
update b_config set note = "FDP_CP_TYPE=1
FDP_CP_TYPE2=2
FDP_CP_TYPE3=3
FDP_CP_ASC=ASC
FDP_CP_ASC_PLAN=ASC_PLAN" where cle = "FD_DT_ACCTYPE"
