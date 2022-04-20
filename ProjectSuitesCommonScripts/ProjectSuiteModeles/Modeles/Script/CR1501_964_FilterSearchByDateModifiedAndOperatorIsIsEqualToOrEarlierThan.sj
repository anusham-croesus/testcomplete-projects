//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
            Préconditions :

           Se connecter avec 'COPERN'

       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-964
        Description : 
        1-Choisir le module modèle.:Le module modèle s'ouvre correctement.
        2-Sélectionner un modèle:Le modèle est bien sélectionné.
        3-Cliquer sur le bouton 'Info':La fenêtre info est ouverte.
        4-Cliquer sur filtre et choisir le filtre 'date de modification:La liste des filtres s'ouvre correctement
         et la fenêtre 'Créer un filtre'  de 'Date de modification' est ouverte.
        5-Choisir 'est égale ou antérieur au'  pour le champ 'Opérateur',saisir une valeur ensuite cliquer sur
         le bouton 'Appliquer':Les notes correspondant au filtre sont affichées.
        
         
        
    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-8--V9-Be_1-co6x
*/
function CR1501_964_FilterSearchByDateModifiedAndOperatorIsIsEqualToOrEarlierThan()
{
  try {
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-964");
      
        //Se connecter avec COPERN
        Log.Error("Je peux pas automatiser ce cas de test suite a l'anomalie: CROES-10858");
       
      
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
       
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
      }  
}
