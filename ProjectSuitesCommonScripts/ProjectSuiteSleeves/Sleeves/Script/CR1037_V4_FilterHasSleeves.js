//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_V4_ColumnSleeve()
{
      try{   
      
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LOTHC", "username"); 
         var filtre =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "filtre_V4", language+client);
         
         Login(vServerSleeves, user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
              
         //Add Column Sleeves
         Get_AccountsGrid_ChName().ClickR();
         Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
         Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: HasSleeve"], 100).Click();
         
          
         //Afficher la fenêtre « Ajouter un filtre » en cliquant sur Toolbar - BtnQuickFilters
         Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
         Get_Toolbar_BtnQuickFilters_ContextMenu_HasSleeves().Click();
        
         //Création d'un filtre
         Get_WinCreateFilter_CmbOperator().DropDown();
         Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
         Get_WinCreateFilter_DgvValue().Find("Value",filtre,100).Click();
         Get_WinCreateFilter_BtnApply().Click();

         //Vérifier que les comptes qu’on voir ces sont des comptes sleevés            
         var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;//Conter les résultats dans le grid    
         for (i=0; i<= count-1; i++){ 
           aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem, "HasSleeve", cmpEqual, true);       
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
    }
}

