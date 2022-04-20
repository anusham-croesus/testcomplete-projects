//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_V9_Filter()
{
      try{   
          var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "COPERN", "username"); 
          var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_800054JJ", language+client); //800054-JJ
          var sleeveDescription= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client) 
          var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client) 
          var relationshipNo =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "RelationshipNo_V9", language+client);
          var accountNo =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_800301NA", language+client);
         
          Login(vServerSleeves, user ,psw,language);
         
          //Créer des sleeves
          Get_ModulesBar_BtnAccounts().Click();
 
          Search_Account(account);
          DragAccountToPortfolio(account);  
         
          Get_PortfolioBar_BtnSleeves().Click();
          Get_WinManagerSleeves().Parent.Maximize(); 
         
          Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
          AddEditSleeveWinSleevesManager(sleeveDescription,sleeveDescription,"","","",model) 
          CheckThatModelBindedToSleeve( sleeveDescription,model);                 
          Get_WinManagerSleeves_BtnSave().Click(); 
          Delay(1500)
         
          //Valider l'ajout du modele                                               
          Get_PortfolioBar_BtnSleeves().Click();
          Get_WinManagerSleeves().Parent.Maximize(); 
          CheckThatModelBindedToSleeve( sleeveDescription,model)
          Get_WinManagerSleeves().Close();
         
          //Aller au module Modeles 
          Get_ModulesBar_BtnModels().Click();  
         
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
          Get_Models_Details_TabAssignedPortfolios().Click();
                          
          Get_ModelsGrid().Find("Value",model,100).Click();
                  
          //Assigner au modèle un client
          Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
          Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
  
          var clientNo = Get_WinPickerWindow_DgvElements().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_ClientNumber();
          Get_WinPickerWindow_DgvElements().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsSelected(true)
          Get_WinPickerWindow_DgvElements().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsActive(true)
  
          Get_WinPickerWindow_BtnOK().Click();
          Get_WinAssignToModel_BtnYes().Click();
         
          //Assigner au modèle une relation
          Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
          Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships().Click();
        
          Get_WinPickerWindow_DgvElements().Find("Value",relationshipNo,10).Click();
    
          Get_WinPickerWindow_BtnOK().Click();
          Get_WinAssignToModel_BtnYes().Click();
                 
          //Assigner au modèle un compte 
          Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
          Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
          Log.Message("L'anomalie présente sur CX : CROES-7952")
  
          Get_WinPickerWindow_DgvElements().Find("Value",accountNo,10).Click();
  
          Get_WinPickerWindow_BtnOK().Click();
          Get_WinAssignToModel_BtnYes().Click();
          
          //******************************************Vérification******************************************************************************************************       
          //filtrer par chaque option: comptes
          Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter().DropDown();
          Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter_ItemAccounts().Click()
             
          aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "AccountNumber", cmpEqual, accountNo);
          aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual, 1);
         
          //filtrer par chaque option: clients
          Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter().DropDown();
          Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter_ItemClients().Click();
         
          aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "ClientNumber", cmpEqual, clientNo);
          aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual, 1);
         
          //filtrer par chaque option:relations
          Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter().DropDown();
          Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter_ItemRelationships().Click();
         
          aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "IdForDisplay", cmpEqual, relationshipNo);
          aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual, 1);
         
          //filtrer par chaque option:sleeves
          Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter().DropDown();
          Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter_ItemSleeves().Click();
         
          aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "AccountNumber", cmpEqual, account);
          aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual, 1);
         
          //filtrer par chaque option: all
          Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter().DropDown();
          Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter_ItemAll().Click();
         
          aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual, 4);
          CheckPresenceOfItems(clientNo)
          CheckPresenceOfItems(account)
          CheckPresenceOfItems(relationshipNo)
          CheckPresenceOfItems(account)
                                 
         //********************************************Remettre les données a l'êtas initial***************************************************************************
         //************************************************************************************************************************************************************    
         //Supprimer le client, le compte,la relation (assignés)   
          DeleteItemsInDetail();
         
          //Supprimer des segments  
          Get_ModulesBar_BtnAccounts().Click();       
          Get_ModulesBar_BtnPortfolio().Click();  
                           
          Delete_AllSleeves_WinSleevesManager();  
                                  
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
        //Remettre les données a l'êtas initial dans le cas d'erreur 
        Login(vServerSleeves, user ,psw,language); 
        Get_ModulesBar_BtnModels().Click();
        //Supprimer le client, le compte,la relation (assignés)   
        DeleteItemsInDetail();
         
        Get_ModulesBar_BtnAccounts().Click();
 
        Search_Account(account);    
        DragAccountToPortfolio(account);  
        //Supprimer des segments 
        Delete_AllSleeves_WinSleevesManager(); 
        
    }
    finally {
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function CheckPresenceOfItems(description)
{
  //Sélectionner le segment
    var count = Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items.Count;
    var found=false;
    
    for (var i = 0; i < count; i++){          
          if(VarToString(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.IdForDisplay)==VarToString(description)){

             Log.Checkpoint("L'item est présent dans la grille de détails")
             found=true;
             break;
          }        
    }
    
    if(found==false){
      Log.Error("L'item n'est pas présent dans la grille de détails")
    }
}


function DeleteItemsInDetail()
{    
    
    var count = Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items.Count;
    
    if(count>1){
    
        for (var i = 0; i < count; i++){ 
              if(i==0){
                Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "",i+1).set_IsSelected(false);             
              }
              else{
                Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsSelected(true); 
                Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsActive(true);  
              }                  
        }   
        Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Click();   
        //Delay(1500);     
        Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
        
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    
    } 
}


