//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-810
   
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2- Sélectionner un client: Le client est bien sélectionné.
         3- Faire un click-right et choisir 'Ajouter une note':La fenêtre 'Ajouter une note' est ouverte.
         4-Cliquer sur le bouton 'Date & Heure'.:L'heure et la date est insérée  sur la partie gauche de la fenêtre 'Ajouter une note'.
         5-Ajouter une phrase prédéfinie ensuite cliquer sur le bouton 'Sauvegarder'.:La phrase prédéfinie sélectionnée est ajoutée et la fenêtre
          'Ajouter une note' est fermée.
         6-Cliquer sur le bouton 'Info' ensuite ouvrir la note crée précédemment.:La fenêtre Info est ouverte et on voit sur la fenêtre de consultation de note la date & heure
          et la phrase prédéfinie qu'on a ajouté précédemment.
          
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_810_Cli__ValidatOperationDateTimebuttonWhenEnteringNotWithClickRight()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-810");
         
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
         var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
         var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
        
        
          Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module client
          Get_ModulesBar_BtnClients().Click();
          Search_Client(numberClient800300)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
          //
          Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
          expectedDateHeure=DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d %H:%M:%S")
          var expectedDateHeureLessSecond=aqDateTime.AddSeconds(aqDateTime.Now(), -1)
          var expectedDateHeure1 = aqString.Insert( expectedDateHeure, "[", 0 );
          var expectedDateHeure2=aqString.Insert( expectedDateHeure1, "]", 20 );
          Log.Message("La date avant de diminuer les secondes"+expectedDateHeure2)
          //Les points de vérifications :L'heure et la date est insérée  sur la partie gauche de la fenêtre 'Ajouter une note'.
          var displayDateHeure=Get_WinCRUANote_GrpNote_TxtNote().wText 
          Log.Message("La date affichée sur la partie ajouter une note"+displayDateHeure)
          if(displayDateHeure != expectedDateHeure2)  
              {
           
          
          expectedDateHeure=DateTimeToFormatStr(expectedDateHeureLessSecond, "%Y-%m-%d %H:%M:%S")
          var expectedDateHeure1 = aqString.Insert( expectedDateHeure, "[", 0 );
          var expectedDateHeure2=aqString.Insert( expectedDateHeure1, "]", 20 );
          Log.Message(expectedDateHeure2)
          Log.Message("La date aprés avoir diminuer une seconde"+expectedDateHeure2) ; 
           
              }
          CheckEquals(displayDateHeure,expectedDateHeure2,"La date et l'heure est ")
          //Ajout d'une phrase prédéfinie
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
          Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
          //La phrase prédéfinie est ajoutée
          var displayDateHeurePhrasePredefine=Get_WinCRUANote_GrpNote_TxtNote().wText  
          //Les points de vérifications: l'heure, la date et la phrase prédéfinie ont été ajoutés
          var expectedDateHeurePhrasePredefine=aqString.Concat(expectedDateHeure2,textphrasePredefiniCROES790);
          CheckEquals(displayDateHeurePhrasePredefine,expectedDateHeurePhrasePredefine,"La date ,l'heure et la phrase prédéfinie sont ")
          var displayDateHeurePhrasePredefineavantFermeture=Get_WinCRUANote_GrpNote_TxtNote().wText  
          
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_BtnSave().Click();
         
          /*  6-Cliquer sur le bouton 'Info' ensuite ouvrir la note crée précédemment.:La fenêtre Info est ouverte et on voit sur la fenêtre de consultation de note la date & heure
          et la phrase prédéfinie qu'on a ajouté précédemment.*/
          Search_Client(numberClient800300)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
          Get_ClientsBar_BtnInfo().Click();
          //Trouver la note ensuite ouvrir 
         Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", expectedDateHeurePhrasePredefine, 10).Click();
         Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
         //Les points de vérifications
          var displayDateHeurePhrasePredefineApresOuvertir=Get_WinCRUANote_GrpNote_TxtNote().wText  
          CheckEquals(displayDateHeurePhrasePredefineApresOuvertir,expectedDateHeurePhrasePredefine,"La date ,l'heure et la phrase prédéfinie sont ")
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_BtnSave().Click();
          Get_WinDetailedInfo_BtnOK().Click();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_Note(displayDateHeure, vServerClients)
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(displayDateHeure, vServerClients)
      
        
    }
}