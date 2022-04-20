//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3225            
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans le module Client et sélectionner une racine d'un client externe(disponible à partir 
                  de la section détails en bas du module clients):La racine est sélectionnée.
                  3.Faire un clic droit et voir si l'option de  relation est disponible:L'option relation n'apparait pas.
                  
                   
    Auteur : Sana Ayaz
*/
function CR1793_3225_Rel_PreventTheJointOfFamilFirmRelatForExterneClient()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
          
        //Les variables
          var Account800256GT=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "Account800256GT", language+client); 
          var rootsBNC_1871= ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "rootsBNC_1871", language+client);
          var NameClientExterneCroesus3225=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "NameClientExterneCroesus3225", language+client);      
        
      
          Login(vServerClients, userNameREAGAR, passwordREAGAR, language);
          Get_ModulesBar_BtnClients().Click();
          Get_Toolbar_BtnAdd().Click();
           var numberOftries=0;  
          while ( numberOftries < 5 && !Get_SubMenus().Exists){
            Get_Toolbar_BtnAdd().Click();
            numberOftries++;
          } 

          Get_ClientsGrid_ContextualMenu_Add_CreateExternalClient().Click();  
     
         
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(NameClientExterneCroesus3225);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Click();
          Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_ItemAC42().Click();
          Get_WinDetailedInfo_BtnOK().Click();
          Get_ModulesBar_BtnClients().Click();
          SearchClientByName(NameClientExterneCroesus3225);
         
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameClientExterneCroesus3225, 10).Click();
         //8.client droit sur sa racine
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1871,10).Find("OriginalValue",NameClientExterneCroesus3225,10).Click();
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1871,10).Find("OriginalValue",NameClientExterneCroesus3225,10).ClickR();
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
        SearchClientByName(NameClientExterneCroesus3225);
        DeleteClient(NameClientExterneCroesus3225);
        Terminate_CroesusProcess();
        
    }
}
