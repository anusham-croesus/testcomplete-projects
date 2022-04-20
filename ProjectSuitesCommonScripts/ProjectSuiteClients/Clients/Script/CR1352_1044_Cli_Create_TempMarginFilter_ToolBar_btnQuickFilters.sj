//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA


/* Description : Création du filtre rapide contenant l’opérateur : est à blanc
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1044
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1044_Cli_Create_TempMarginFilter_ToolBar_btnQuickFilters()
 {   
    var clientName="testauto"
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
    if (client == "BNC" ){
      //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
      Get_Toolbar_BtnQuickFilters_ContextMenu_Margin().Click();
      Get_WinCreateFilter_CmbOperator().DropDown();
      Get_WinCRUFilter_CmbOperator_ItemIsEmpty().Click();
      Get_WinCreateFilter_BtnApply().Click();  
      
      //Vérifier le texte de message 
      aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, "Le filtre que vous avez appliqué ne contient aucune donnée.");
      Get_DlgWarning().Close()
      //Les points de vérification : Vérifier que le nombre de résultats dans le grid et
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 0)
      
    }
    else{//RJ
     //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
      Get_Toolbar_BtnQuickFilters_ContextMenu_Email1().Click();
      Get_WinCreateFilter_CmbOperator().DropDown();
      Get_WinCRUFilter_CmbOperator_ItemIsEmpty().Click();
      Get_WinCreateFilter_BtnApply().Click(); 
      
      //Les points de vérification : Vérifier que le nombre de résultats dans le grid et
//      if(client == "CIBC"){ 
//          Get_DlgWarning().Close();   // Pour CIBC ce filtre ne retourne pas de resultats
//          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 0);
//      }
//      else 
          if(client == "TD"){
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 5)
          } 
          else{
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 1)}
          }       
   
   try {
        //Créer un client externe , ne pas remplir le champs Margin
        Get_Toolbar_BtnAdd().Click();
        Get_Toolbar_BtnAdd_AddDropDownMenu_CreateExternalClient().Click();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(clientName);
        Get_WinDetailedInfo_BtnOK().Click();
    
        if (client == "BNC" || client == "CIBC"){
          //Les points de vérification : Vérifier que le nombre de résultats dans le grid et  
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 1);
        }
        else if(client == "TD" ){
           aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 6);
        } 
        else{
        //Les points de vérification : Vérifier que le nombre de résultats dans le grid et  
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 2);
        }
        
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();
   }
   catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
   }
   finally{
   
        Execute_SQLQuery("DELETE from b_client where NOM='"+clientName+"'",vServerClients);
   }
 }
 


