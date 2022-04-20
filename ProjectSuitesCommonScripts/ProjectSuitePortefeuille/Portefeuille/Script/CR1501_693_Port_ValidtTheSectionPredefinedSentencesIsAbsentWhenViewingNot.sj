//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-693
    Description :
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2-  Sélectionner un client: Le client est bien sélectionné.
         3- Mailler ce client vers le module portefeuille:Le module portefeuille s'ouvre correctement.
         4- Sélectionner une position qui contient des notes:La position est bien sélectionnées.
         5- Cliquer sur le bouton Info ensuite cliquer sur le bouton 'Consulter' pour consulter une note:La fenêtre info est ouverte et 
         la fenêtre Consulter une note' est ouverte aussi.
         6-Vérifier que la section des phrases prédéfinies est absente:la section des phrases prédéfinies est absente.
        
            
                   
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-1--V9-Be_1-co6x
*/


function CR1501_693_Port_ValidtTheSectionPredefinedSentencesIsAbsentWhenViewingNot()
{
    try {
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         //Les variables
          var numberAccount800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800300NA", language+client);
          var positionDescripCROES566=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "positionDescripCROES566", language+client);
          var PortTextAddNotTestCROES693=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES693", language+client);
          var SectionPredefinedSentencesCROES693=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "SectionPredefinedSentencesCROES693", language+client);
          
          Login(vServerPortefeuille, userNameCOPERN, passwordCOPERN, language);
         //Choisir le module compte
          Get_ModulesBar_BtnAccounts().Click();
          //Sélectionner le compte 800300-NA
         Search_Account(numberAccount800300NA)
         
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800300NA, 10).Click();
          
           //Mailler vers le module portefeuille
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          
           Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
           Search_PositionByAccountNo(numberAccount800300NA)
           Search_PositionByDescription(positionDescripCROES566)
  
           Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).Click();
           Get_PortfolioBar_BtnInfo().Click()
           Get_WinPositionInfo_TabNotes().Click();
           Get_WinInfo_Notes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
           //Ajout D'une note
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotTestCROES693);
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          
          Get_WinCRUANote_BtnSave().WaitProperty("IsEnabled", true, 30000); 
          Get_WinCRUANote_BtnSave().Click();
          
          Get_WinPositionInfo_BtnOK().Click();
          //Se connecter avec Keynej pour avoir le bouton consulter
          Login(vServerPortefeuille, userNameKEYNEJ, passwordKEYNEJ, language);
           //Choisir le module compte
          Get_ModulesBar_BtnAccounts().Click();
          //Sélectionner le compte 800300-NA
         Search_Account(numberAccount800300NA)
         
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800300NA, 10).Click();
          
           //Mailler vers le module portefeuille
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          
           Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
           Search_PositionByAccountNo(numberAccount800300NA)
           Search_PositionByDescription(positionDescripCROES566)
  
           Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).Click();
           Get_PortfolioBar_BtnInfo().Click()
           Get_WinPositionInfo_TabNotes().Click();
           Get_WinInfo_Notes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_BtnDisplay().Click();
           //Les points de vérifications:Vérifier que la section des phrases prédéfinies est absente
            var existancePredefinedSentence=  Get_WinNoteDetail().FindChild("WPFControlText", SectionPredefinedSentencesCROES693, 10).Exists;
            var visibleOnScreenPredefinedSentence=  Get_WinNoteDetail().FindChild("WPFControlText", SectionPredefinedSentencesCROES693, 10).VisibleOnScreen;
            Log.Message(existancePredefinedSentence);
            Log.Message(visibleOnScreenPredefinedSentence);
            
            if((existancePredefinedSentence == true) && (visibleOnScreenPredefinedSentence == true))
            {
              
               Log.Error("La section des phrases prédéfinies est présente alors qu'elle doit pas être présente")
            }
            else
            {
               Log.Checkpoint("La section des phrases prédéfinies est absente")
             }
          
         
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotTestCROES693, vServerPortefeuille)
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotTestCROES693, vServerPortefeuille)
        
    }
}
