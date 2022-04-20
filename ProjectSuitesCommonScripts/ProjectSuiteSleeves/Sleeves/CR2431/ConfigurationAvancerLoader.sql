--===========================================================ÉTAPE 1
--MODIFIER LES RÉPERTOIRES POUR LES FICHIERS À TRAITER...EXEMPLE
update b_config set note = '/home/aminea/loader/CR2431' where cle = 'FD_MAIN_DIR' 
update b_config set note = '/home/aminea/loader/CR2431' where cle = 'FD_DATA_DIR'
--Ajouter les fichiers PRO/SEC/TRA/BKV/Fundata etc dans le répertoire définit ci-dessus
--Le fichier PRICE.TXT est un fichier optionnel traité par les clients, à tester lors de nouvelles versions de chargeur si nécessaire

--===========================================================ÉTAPE 2
--POUR MODIFIER LE MODE STANDARD À UN MODE BKV
--1- Aucun traitement, 2- Traitement partiel=pm et Vi seul. si pas définit 3- Traitement complet=prix_moyen seul. est remplacé 6- CIBC HYBRIDE
update b_config set note = '3' where cle = 'FD_BKV_PROCESS'

update b_config set note = 'ACTIONS=1 4 3' + Char(13) +'RANK=30' + Char(13) +'DATE=2010.01.22' + Char(13) +'TIME=9599' + Char(13) +'AVG_TIME=8431' + Char(13) +'NO_SAMPLES=20' + Char(13) +'STATUS=0' where cle = 'FD_STATUS_F_BKV'

update b_config set note = 'ACTIONS=7 13 7' + Char(13) +'RANK=31' + Char(13) +'DATE=2010.01.22' + Char(13) +'TIME=2472' + Char(13) +'AVG_TIME=1380' + Char(13) +'NO_SAMPLES=100' + Char(13) +'STATUS=0' where cle = 'FD_STATUS_P_BKV'

--===========================================================ÉTAPE 3
---*****IMPORTANT À EXÉCUTER SI ON NE VEUT PAS BLOQUER DES TRAITEMENTS
update b_config set note = null where cle like 'FD_TRANS_CNTR%'

--===========================================================ÉTAPE 4
--MODIFICATION DES CONFIGURATIONS POUR TRAITER DES FICHIERS UFF ET XML DANS BDQA
update b_config set note = 'OLD_EXT=xml UFF' + Char(13) +'PROC_EXT=*' where cle = 'FD_FILE_EXT'

update b_config set note = 'TYPE=proData' + Char(13) +'PREFIX=pro_' where cle = 'FD_PRO_NAME'

update b_config set note = 'TYPE=traData' + Char(13) +'PREFIX=tra_' where cle = 'FD_TRA_NAME'

update b_config set note = 'TYPE=bkvData' + Char(13) +'PREFIX=bkv_' where cle = 'FD_BKV_NAME'

update b_config set note = 'TYPE=recData' + Char(13) +'PREFIX=REC_' where cle = 'FD_REC_NAME'

--mise à jour si on utilise un fichier XML
update b_config set note = 'TYPE=secData' + Char(13) +'PREFIX=sec_' where cle = 'FD_SEC_NAME'

update b_config set note = 'TYPE=MF-DIST' + Char(13) +'PREFIX=MFD_' where cle = 'FD_MFD_NAME'

go