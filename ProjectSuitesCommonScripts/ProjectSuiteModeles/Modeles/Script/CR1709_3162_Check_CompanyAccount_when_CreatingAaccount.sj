//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA


/* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3162
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper */
 
 function CR1709_3162_Check_CompanyAccount_when_CreatingAaccount(){ 
     
 try{
      var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");                         
      var fictifClient=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "fictifClient_3162", language+client);
      var externClient=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "externClient_3162", language+client);
      var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "codeCP_3162", language+client);
    
      Login(vServerModeles, user, psw, language);
      Get_ModulesBar_BtnClients().Click();    
      Get_MainWindow().Maximize();
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            
      //Ajouter un client fictif
      Get_Toolbar_BtnAdd().Click();
      Get_ClientsGrid_ContextualMenu_Add_CreateFictitiousClient().Click();    
      Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(fictifClient);
      Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClient().Keys(codeCP);
      Get_WinDetailedInfo_BtnOK().Click();
      
      SearchClientByName(fictifClient)      
      Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",fictifClient,10), Get_ModulesBar_BtnAccounts());
      
      if(Get_DlgCroesus().Exists){
        var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/2)),73);
      }
      
      Get_Toolbar_BtnAdd().Click();
      aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_ChkBusinessAccount(), "Exists", cmpEqual,true); 
      aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_ChkBusinessAccount(), "VisibleOnScreen", cmpEqual,true);
      Get_WinDetailedInfo_BtnCancel().Click();
      
      Get_ModulesBar_BtnClients().Click(); 
      //Ajouter un client externe
      Get_Toolbar_BtnAdd().Click();
      Get_ClientsGrid_ContextualMenu_Add_CreateExternalClient().Click();    
      Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(externClient);
      Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClient().Keys(codeCP);
      Get_WinDetailedInfo_BtnOK().Click();
            
      SearchClientByName(externClient)      
      Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",externClient,10), Get_ModulesBar_BtnAccounts());
      
      if(Get_DlgCroesus().Exists){
        var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/2)),73);
      }
      
      Get_Toolbar_BtnAdd().Click();
      aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_ChkBusinessAccount(), "Exists", cmpEqual,true); 
      aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_ChkBusinessAccount(), "VisibleOnScreen", cmpEqual,true);
      Get_WinDetailedInfo_BtnCancel().Click();
            
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
        Terminate_CroesusProcess(); //Fermer Croesus 
        Execute_SQLQuery("delete from b_client where nom='"+fictifClient+"'",vServerModeles)
        Execute_SQLQuery("delete from b_client where nom='"+externClient+"'",vServerModeles) 
    }
 }
