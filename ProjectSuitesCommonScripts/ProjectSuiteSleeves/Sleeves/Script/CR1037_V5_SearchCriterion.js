//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective
//USEUNIT DBA

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_V5_ColumnSleeve()
{
      try{   
      
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LOTHC", "username");         
         var criterion = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinAddSearchCriterionTxtName_V5", language+client);
         
         Login(vServerSleeves, user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
         
         //Add Column Sleeves
         Get_AccountsGrid_ChName().ClickR();
         Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
         Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: HasSleeve"], 100).Click();
                  
         Get_Toolbar_BtnManageSearchCriteria().Click();
         
         //Ajouter un critère de recherche en cliquant sur Ajouter              
         Get_WinSearchCriteriaManager_BtnAdd().Click();
        
         Get_WinAddSearchCriterion_TxtName().Clear();
         Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
         Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click(); 
         Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click()
         Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
         Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
         Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSleeves().Click();
         Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
         Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
         Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
         Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes().Click();                 
         Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click()
         Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click()
         Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();   
         Delay(2000);
         
         Get_RelationshipsClientsAccountsGrid().Refresh();
         
         //Vérifier que les comptes qu’on voir ces sont des comptes sleevés            
         var count = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count;//Conter les résultats dans le grid  
         Log.Message(count) 
         for (i=0; i< count-1; i++){ 
           aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "HasSleeve", cmpEqual, true);
           Log.Message(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.FullName)       
         }
                   
         //Remove Column          
         Get_AccountsGrid_ChSleeves().ClickR();
         Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();  
                                                                               
    }
    catch(e) {
    
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
        //Remettre les données a l'êtas initial dans le cas d'erreur 
        Login(vServerSleeves, user ,psw,language);
        Get_ModulesBar_BtnAccounts().Click();
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
    }
    finally {
      Terminate_CroesusProcess(); //Fermer Croesus
      Delete_FilterCriterion(criterion,vServerSleeves)//Supprimer le filtre de BD 
    }
}



