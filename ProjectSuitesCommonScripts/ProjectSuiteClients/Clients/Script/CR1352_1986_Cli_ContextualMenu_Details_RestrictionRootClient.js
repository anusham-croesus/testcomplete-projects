//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions

/* Description :Fonction restriction du menu contextuel de la section Détail
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1986
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ //il faut finaliser le script 
 
 function CR1352_1986_Cli_ContextualMenu_Details_RestrictionRootClient()
 {             
// Script spécifique a BNC
      var rootClient="800272"
      var restriction ="AAER INC"   
      var roots= GetData(filePath_Clients,"CR1352",202,language)  
      var accounts= GetData(filePath_Clients,"CR1352",206,language)   
      var user=GetData(filePath_Clients,"CR1352",76,language) 

      Login(vServerClients,userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
    
      //chercher un client 
      Search_Client(rootClient);
            
      //Vérification pour le client principal
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("OriginalValue",rootClient,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("OriginalValue",rootClient,10).ClickR();
      //Vérifier que la fonction Restrictions est grisée
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Restrictions(),"IsEnabled",cmpEqual,false);
      

      //Vérification pour le client racines  800272
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("Description",roots,10).Find("OriginalValue",rootClient,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("Description",roots,10).Find("OriginalValue",rootClient,10).ClickR();   
      //Vérifier que la fonction Restrictions n'est pas grisée
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Restrictions(),"IsEnabled",cmpEqual,true);  
      
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Restrictions().Click();    
      aqObject.CheckProperty(Get_WinRestrictionsManager(), "Title", cmpContains,rootClient);      
      aqObject.CheckProperty(Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1).Items,"Count",cmpEqual,0)
      
      //Ajout d’une restriction 
      Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
      Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys(restriction);

      Get_WinCRURestriction_GrpSecurity_BtnQuickSearchListPicker().Click();
      Get_WinCRURestriction_GrpSecurity_BtnQuickSearchListPicker().Click();
      
      if(Get_WinCRURestriction_BtnOK().WaitProperty("IsEnabled",true,5000)){
        Get_WinCRURestriction_BtnOK().Click();
      }
      
      //Vérification qu’une restriction a été ajoutée  
      aqObject.CheckProperty(Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1).Items,"Count",cmpEqual,1)
      aqObject.CheckProperty(Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem,"Description",cmpContains,restriction)
      
      Get_WinRestrictionsManager().Find("Value",user,10).Click();
      
      if(Get_WinRestrictionsManager_BarPadHeader_BtnDelete().WaitProperty("IsEnabled",true,5000)){   
          Get_WinRestrictionsManager_BarPadHeader_BtnDelete().Click();
      }
      else{
          Log.Error("Le btn Delete n’est pas actif");
      }
      
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      Get_WinRestrictionsManager_BtnClose().Click();
             
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();
   
 }
 
