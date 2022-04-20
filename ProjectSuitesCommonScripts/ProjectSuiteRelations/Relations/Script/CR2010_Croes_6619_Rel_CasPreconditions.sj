//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT DBA


/*
Module: Relations / Création des relations avec les comptes
 
Auteur :   Jimenab
Analyste Manuel :  carolet
Version de scriptage:	ref90-12-HF-20 

*/


function CR2010_Croes_6619_Rel_CasPreconditions()

{
  try 
  {
    
        
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_HISTO_RELATIONSHIPS","YES",vServerRelations);
        RestartServices(vServerRelations);
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","KEYNEJ","username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var accountNumber800203RE = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800203RE", language+client);
        var accountNumber800204FS = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204FS", language+client);
        var IACodeRel = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "IACodeRel", language+client);
        var ModelCHBONDS = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"CR2010","ModelCHBONDS", language+client);
        var RemovalDate = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"CR2010","RemovalDate", language+client);
        var accountNumber800212RE = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","accountNumber800212RE", language+client);
        var accountNumber800213NA = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","accountNumber800213NA", language+client);
        var GroupedRelationName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","GroupedRelationName", language+client);
        var NewRel01 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","NewRel01", language+client);
        var NewRel02 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","NewRel02", language+client);
        var acccount=new Array(accountNumber800203RE, accountNumber800204FS,accountNumber800212RE,accountNumber800213NA );
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6619");
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language)
              
        Log.Message("Aller dans le module relation");
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Log.Message("Créer une nouvelle relation" +NewRel01);
        CreateRelationship(NewRel01, IACodeRel);
        
        Log.Message("Associer la" +NewRel01+ "vers les comptes" + accountNumber800203RE + "et"  +accountNumber800204FS);
        JoinAccountToRelationship(accountNumber800203RE, NewRel01);
        JoinAccountToRelationship(accountNumber800204FS, NewRel01);
        
        Get_RelationshipsClientsAccountsGrid().Find("Value", NewRel01, 10).Click();
       
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",accountNumber800203RE,10), "Exists", cmpEqual, true);  
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",accountNumber800203RE,10), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",accountNumber800204FS,10), "Exists", cmpEqual, true);  
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",accountNumber800204FS,10), "VisibleOnScreen", cmpEqual, true); 
        
        Log.Message ("Relation " +NewRel01+ " créée et comptes ajoutés à la relation");
   
        
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","QuickSearchWindow_b326");
        var dragSource = Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel01, 10);
        var dragDestinationAcc = Get_ModulesBar_BtnAccounts();
        Drag(dragSource, dragDestinationAcc);
        
        WaitObject(Get_CroesusApp(), "Uid", "CustomizableMenu_df61");
        Get_MenuBar_Edit().Click();  
        Get_MenuBar_Edit_SelectAll().Click();
        
        
        Log.Message("Les comptes de la relation sont dragged lors de passer au module comptes");
   
        Get_RelationshipsClientsAccountsGrid().Find("Value", accountNumber800203RE,10).Click();
        Log.Message("Sélectionner avec Shift key-> Faire un rigth click --> »Associer à un modèle -->  modèle CH Bonds");
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNumber800203RE, 10).Keys("[Hold]![Down][Release]");
        Get_RelationshipsClientsAccountsGrid().ClickR(667, 13);        
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignToAModel().Click();
        
        
        
            
        Log.Message("Cherche dans la liste des modèles " + ModelCHBONDS);
        Get_WinPickerWindow_DgvElements().Keys("M"); 
        Get_WinQuickSearch_TxtSearch().SetText(ModelCHBONDS);
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
        
        
        aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem,"AccountNumber", cmpEqual, accountNumber800203RE);  
        aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem,"AccountNumber", cmpEqual, accountNumber800204FS); 
        Log.Message("Les comptes " +accountNumber800203RE+ "et" +accountNumber800204FS+ " sont associés au modèle CH BONDS");  
    
        Log.Message("Revenir dans Relations");
        Get_ModulesBar_BtnRelationships().Click();
        Log.Message("Faire info relation de" +NewRel01+ "et aller dans l'onglet Comptes sous-jacents");
        Get_RelationshipsBar_BtnInfo().Click(); 
        WaitObject(Get_WinDetailedInfo(),["ClrClassName","WPFControlText"],["UniButton","OK"]);
      
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship().Click();
        
        Log.Message("sur le compte" +accountNumber800204FS+ "cliquer sur Modifier -->  date de sortie =  05/01/2009 (5 janv 2009)");
        // Format 'mm/dd/yyyy'  
        
       
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().Findchild("Value", accountNumber800204FS,10).Click();
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit().Click();
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount_TxtRemovalDate().Click();
        Delay(2000);
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount_TxtRemovalDate().Keys(RemovalDate);
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount_BtnOK().Click();

        
        var RemovalDateAccount = (Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.RemovalDate.OleValue);
        Log.Checkpoint("Date de sortie ajoutée " +RemovalDateAccount + " sur le compte 800204-FS");
        Get_WinDetailedInfo_BtnOK().Click();   
             
        
        var acccountRel02=new Array(accountNumber800212RE, accountNumber800213NA);
 
        
        Log.Message("Créer une nouvelle relation" +NewRel02);
        CreateRelationship(NewRel02, IACodeRel);
        
        Log.Message("Associer la" +NewRel02+ "vers les comptes" + accountNumber800212RE + "et"  +accountNumber800213NA);
        JoinAccountToRelationship(accountNumber800212RE, NewRel02);
        JoinAccountToRelationship(accountNumber800213NA, NewRel02);
        
        Get_RelationshipsClientsAccountsGrid().Find("Value", NewRel02, 10).Click(); 
        
       
        
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",accountNumber800212RE,10), "Exists", cmpEqual, true);  
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",accountNumber800212RE,10), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",accountNumber800213NA,10), "Exists", cmpEqual, true);  
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",accountNumber800213NA,10), "VisibleOnScreen", cmpEqual, true); 
        Log.Message ("Relation " +NewRel02+ " créée et comptes ajoutés à la relation");
        
           
        
        Log.Message("Faire info relation de " +NewRel02+ " et aller dans l'onglet Comptes sous-jacents sur le " + accountNumber800213NA);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel02, 10).Click();
        Get_RelationshipsBar_BtnInfo().Click(); 
        
        WaitObject(Get_WinDetailedInfo(),["ClrClassName","WPFControlText"],["UniButton","OK"]);
      
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship().Click();
 
        //Format 'mm/dd/yyyy'  
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().Findchild("Value", accountNumber800213NA,10).Click();
        Log.Message("sur le compte " +accountNumber800213NA+ " cliquer sur Modifier -->  date de sortie =  05/01/2009 (5 janv 2009)");
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit().Click();
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount_TxtRemovalDate().Click();
        Delay(2000);
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount_TxtRemovalDate().Keys(RemovalDate);
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount_BtnOK().Click();
     
        var RemovalDateAccount = (Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.RemovalDate.OleValue);
        Log.Checkpoint("Date de sortie ajoutée " +RemovalDateAccount + " sur le compte " +accountNumber800213NA);
    
        Get_WinDetailedInfo_BtnOK().Click();
           
        
        Log.Message("Créer une nouvelle relation groupée --> Associer  nom : REL01---REL02");
    
        CreateGroupedRelationship(GroupedRelationName, IACodeRel);
        JoinToAGroupedRelationship(NewRel01, GroupedRelationName);
        JoinToAGroupedRelationship(NewRel02, GroupedRelationName);
          
        SearchRelationshipByName(GroupedRelationName);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", GroupedRelationName, 10).Click();
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10), "Exists", cmpEqual, true);  
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel02,10), "Exists", cmpEqual, true);  
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel02,10), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value", GroupedRelationName, 10), "VisibleOnScreen", cmpEqual, true);
        Log.Message("Relation groupée " + GroupedRelationName + " créée avec les relations " + NewRel01 +  " et " + NewRel02);
    
  }
  
    catch(e){
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
    
    }
    finally {
         Terminate_CroesusProcess();
        
    }
  
}







