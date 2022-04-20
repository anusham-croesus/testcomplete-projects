//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT BNC_1748_RebalaCriteriaForARepresentaTheDefaultAccessLevelShouldBeWorkgroupJEFFET


/**
       Pour l`automatisation, utiliser les users de différents niveaux : REAGAR, JEFFET, KEYNEJ et UNI00 :
      1. sélectionner un modele puis cliquer sur Criteres de rééquilibrage
      2. cliquer sur Associer/Gérer

      Résultat attendu si critere existe déjà : valider que le niveau d`acces = Équipe de travaille

      3.Sinon, Sauvegarder un critre, par exemple : Pour chaque titre acheter position dans un compte.

      4.Résultat attendu : niveau d`acces reste 'Équipe de travail' apres sauvegarde

      5. Fermer
    Auteur : Sana Ayaz
    Anomalie:BNC-1748
    Version de scriptage:90-04-BNC-59B-9
*/

function BNC_1748_RebalaCriteriaForARepresentaTheDefaultAccessLevelShouldBeWorkgroupUNI00()
{var UserName="UNI00";
 var PassWord="UNI00"
 var NameModel="NameModelCROESUS_1748"
BNC_1748_RebalaCriteriaForARepresentaTheDefaultAccessLevelShouldBeWorkgroup(UserName,PassWord,NameModel)
}
