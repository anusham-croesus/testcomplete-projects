//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3220            
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans le module Client et sélectionner une racine d'un client fictif et/ou externe(disponible à partir 
                  de la section détails en bas du module clients):La racine est sélectionnée.
                  3.Faire un clic droit et voir si l'option de  relation est disponible:L'option relation n'apparait pas.
                  
                   
    Auteur : Sana Ayaz
*/
function CR1793_3220_Rel_PreventTheCreatOfFamilFirmRelatForFictifClient()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
          
        //Les variables
          var Account800256GT=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "Account800256GT", language+client); 
          var NameClIENTFICTIF3220=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "NameClIENTFICTIF3220", language+client);
          var rootsBNC_1871= ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "rootsBNC_1871", language+client);
          var CreateFamilyFirmRelationshipBNC_1871 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "CreateFamilyFirmRelationshipBNC_1871", language+client);
          var JoinToAFamilyFirmRelationshipBNC_1871 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "JoinToAFamilyFirmRelationshipBNC_1871", language+client);
          var AssignToAnExistingModelBNC_1871 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "AssignToAnExistingModelBNC_1871", language+client);
          var RelationshipBNC_1871 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "RelationshipBNC_1871", language+client);
          var NameClIENTFICTIF3220Rech=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "NameClIENTFICTIF3220Rech", language+client);      
        
      
         Login(vServerClients, userNameREAGAR, passwordREAGAR, language);
        
         Get_ModulesBar_BtnAccounts().Click();
        //Mailler un compte de VT > 0 vers portefeuille 800300-NA
         Search_Account(Account800256GT);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", Account800256GT, 10).Click();
        //Mailler le compte 800300-NA vers le module portefeuille
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          // 2.cliquer sur Simulation
          Get_PortfolioBar_BtnWhatIf().Click();
          //3.cliquer sur Sauvergarder
          Get_PortfolioBar_BtnSave().Click();
          //4.cliquer sur Sauvegarde détaillée en laissant Nouveau compte fictif coché 
          Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount().set_IsChecked(true);
          Get_WinWhatIfSave_BtnDetailedSave().Click();
         //5.sauvegardé avec un nouveau nom abrégé(commenÇant par *)
         Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(NameClIENTFICTIF3220);
         Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(NameClIENTFICTIF3220);
         Get_WinDetailedInfo_BtnOK().Click();
         Get_DlgInformation().Close();
         Get_ModulesBar_BtnClients().Click();
         SearchClientByName(NameClIENTFICTIF3220Rech);
         
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameClIENTFICTIF3220Rech, 10).Click();
         //8.client droit sur sa racine
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1871,10).Find("OriginalValue",NameClIENTFICTIF3220Rech,10).Click();
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1871,10).Find("OriginalValue",NameClIENTFICTIF3220Rech,10).ClickR();
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship(), "Exists", cmpEqual, false);      

         if(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Exists)
          
          {
          if (Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().VisibleOnScreen){  
            Log.Error("L'option relation existe ")
          }
           else{
             Log.Checkpoint("L'option relation n'existe pas")
           }
         }
         
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
        
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel(), "Enabled", cmpEqual, false);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel(), "IsVisible", cmpEqual, true);
         Log.Message("Cette différence a été déjà envoyée à Mamoudou, on n’a pas reçue la réponsee")
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel(), "WPFControlText", cmpEqual, AssignToAnExistingModelBNC_1871);
         
         
              
           }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    //Initialiser la BD
        Terminate_CroesusProcess();
        Login(vServerClients, userNameREAGAR, passwordREAGAR, language);
        Get_MainWindow().Maximize(); 
        Get_ModulesBar_BtnClients().Click();
        SearchClientByName(NameClIENTFICTIF3220Rech);
        DeleteClient(NameClIENTFICTIF3220Rech);
        Terminate_CroesusProcess();
        
    }
}

