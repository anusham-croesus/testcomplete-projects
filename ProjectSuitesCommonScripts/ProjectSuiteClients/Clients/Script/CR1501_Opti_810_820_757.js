//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    Regroupement des cas de tests :  Croes-810,Croes-820 et Croes-757
          
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-19-2020-09-23--V9-croesus-co7x-2_1_758
*/


function CR1501_Opti_810_820_757()
{
    try {
          

/****************************************************************Début du cas de test Croes-810******************************************************************************/
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Le cas de test Croes-810 ");     
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-810");
         
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
         
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
          expectedDateHeure=DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d %H:%M:%S")
          var expectedDateHeureLessSecond=aqDateTime.AddSeconds(aqDateTime.Now(), -1)
          var expectedDateHeureAddSecond=aqDateTime.AddSeconds(aqDateTime.Now(), 1)
          
          var expectedDateHeure1 = aqString.Insert( expectedDateHeure, "[", 0 );
          var expectedDateHeure2=aqString.Insert( expectedDateHeure1, "]", 20 );
          Log.Message("La date avant de diminuer les secondes"+expectedDateHeure2)
          //Les points de vérifications :L'heure et la date est insérée  sur la partie gauche de la fenêtre 'Ajouter une note'.
          var displayDateHeure=Get_WinCRUANote_GrpNote_TxtNote().wText 
          Log.Message("La date affichée sur la partie ajouter une note"+displayDateHeure)
            
              
              if(displayDateHeure != expectedDateHeure2)  
              {
           
          
          expectedDateHeure=DateTimeToFormatStr(expectedDateHeureAddSecond, "%Y/%m/%d %H:%M:%S")
          var expectedDateHeure1 = aqString.Insert( expectedDateHeure, "[", 0 );
          var expectedDateHeure2=aqString.Insert( expectedDateHeure1, "]", 20 );
          Log.Message(expectedDateHeure2)
          Log.Message("La date aprés avoir ajouter une seconde"+expectedDateHeure2) ; 
           
              }
              
                        if(displayDateHeure != expectedDateHeure2)  
              {
           
          
          expectedDateHeure=DateTimeToFormatStr(expectedDateHeureLessSecond, "%Y/%m/%d %H:%M:%S")
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
//          Search_Client(numberClient800300)
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
          Terminate_CroesusProcess();
          
/****************************************************************Fin du cas de test Croes-810******************************************************************************/

/****************************************************************Début du cas de test Croes-820******************************************************************************/
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Le cas de test Croes-757 ");  
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-757");
          Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","NO",vServerClients);
          RestartServices(vServerClients);
          Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module client
          Get_ModulesBar_BtnClients().Click();
          Search_Client(numberClient800300)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
          Get_ClientsBar_BtnInfo().Click();
          //Trouver la note ensuite ouvrir 
          Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", expectedDateHeurePhrasePredefine, 10).Click();
             //Les points de vérification
         if(Get_WinInfo_Notes_TabGrid_BtnEdit().Exists && Get_WinInfo_Notes_TabGrid_BtnEdit().VisibleOnScreen )
         {
           Log.Error("Le bouton modifier existe et visble sur l'écran");
         }
         else
         { 
            if(Get_WinInfo_Notes_TabGrid_BtnDisplay().Exists && Get_WinInfo_Notes_TabGrid_BtnDisplay().VisibleOnScreen )
            {
              aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "Enabled", cmpEqual, true);
              Log.Checkpoint("Le bouton consulter existe et visible sur l'écran") 
            }
         }

/****************************************************************Fin du cas de test Croes-757******************************************************************************/

/****************************************************************Début du cas de test Croes-820******************************************************************************/
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Le cas de test Croes-820 ");  
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-820");

          //Cliquer sur le bouton consulter pour consulter la note
           Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value",expectedDateHeurePhrasePredefine, 10).Click();
           Get_WinInfo_Notes_TabGrid_BtnDisplay().Click();
           /*4-Vérifier que le contenu des champs 'Client', 'Date de création' et 'Créée par' est grisé.:Le contenu des champs 'Client', 
         'Date de création' et 'Créée par' est grisé.*/
         Log.Message("en anglais il faut voir pour le titre de la fenêtre a display a note est devenue View a note")
         
         if(client == "CIBC"){
                 //Client   
                 aqObject.CheckProperty(Get_WinNoteDetail_TxtPositionForPositionAndSecurity(), "Enabled", cmpEqual, false);// 
                 aqObject.CheckProperty(Get_WinNoteDetail_TxtPositionForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
                 
                 //Date de création:
                 aqObject.CheckProperty(Get_WinNoteDetail_TxtCreationDateForPositionAndSecurity(), "Enabled", cmpEqual, false);
                 aqObject.CheckProperty(Get_WinNoteDetail_TxtCreationDateForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
                 
                 //'Créée par'
                 aqObject.CheckProperty(Get_WinNoteDetail_TxtCreatedByForPositionAndSecurity(), "Enabled", cmpEqual, false);
                 aqObject.CheckProperty(Get_WinNoteDetail_TxtCreatedByForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
                 }
         else{
               //Client
               aqObject.CheckProperty(Get_WinCRUANote_TxtPositionForPositionAndSecurity(), "Enabled", cmpEqual, false);// 
               aqObject.CheckProperty(Get_WinCRUANote_TxtPositionForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
               //Date de création:
         
               aqObject.CheckProperty(Get_WinCRUANote_TxtCreationDateForPositionAndSecurity(), "Enabled", cmpEqual, false);
               aqObject.CheckProperty(Get_WinCRUANote_TxtCreationDateForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
               //'Créée par'
         
               aqObject.CheckProperty(Get_WinCRUANote_TxtCreatedByForPositionAndSecurity(), "Enabled", cmpEqual, false);
               aqObject.CheckProperty(Get_WinCRUANote_TxtCreatedByForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
               }             
  
/****************************************************************Fin du cas de test Croes-820******************************************************************************/

 


           
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_Note(displayDateHeure, vServerClients)
       
        
        
    }
    finally {
   
         Terminate_CroesusProcess();
         Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerClients);
         RestartServices(vServerClients);
         Delete_Note(displayDateHeure, vServerClients)
      
        
    }
}

