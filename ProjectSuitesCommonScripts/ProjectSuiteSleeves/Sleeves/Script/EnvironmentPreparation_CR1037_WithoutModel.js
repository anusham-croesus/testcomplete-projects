//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


 /* Description : - Se connecter avec UNI00
    -Choisir le module compte 
    -Chercher le compte : "account"
    -Mailler ce compte vers le module Portefeuille
    -Cliquer sur le bouton Par classe d'actifs
    -Sélectionner tous les regroupements par classe d'actifs
    -Faire un right-click ensuite choisir créer des segments ensuite cliquer sur sauvegarder (fenêtre Gestionnaire des segments -comptes ) pour valider la saisie du segment.

Analyste d'automatisation: Youlia Raisper */ 

 function EnvironmentPreparation_CR1037_WithoutModel()
{        
    
    Driver = DDT.ExcelDriver(filePath_Sleeves, "DataPool_WithoutModel", true);
    //Filename: is the name of excel file being used.
   //Sheet: is the excel sheet which has the data, that will be used for test.
   //UseAceDriver: a Boolean value. If True, TestComplete makes use of ACE driver to connect an excel sheet. 
   //If it is False, TestComplete connects to the excel sheet via the Microsoft Excel ODBC driver.
   // ACE driver lets us to connect Excel 2007 sheets together with earlier version of Microsoft Excel.

    while(!Driver.EOF())
  {
      try{
          var account=Driver.Value(0)
          
          var  user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
          Log.Message("******************Environment Preparation for " +account+"*********************************")
          Login(vServerSleeves, user ,psw,language);
          Get_ModulesBar_BtnAccounts().Click();
  
          Search_Account(account);  
          if(account=="800053-NA" || account=="800077-RE"){
            UncheckInvestmentObjectiveWinInfo(account)
          }
          
          DragAccountToPortfolio(account); //Driver.Value(n), carries the data from excel sheet. The first column of the excel sheet is read as zeroth column.    
          CreateSleeveByAssetClass();  
      
          //Vérifier que des segments ont été créés
          //faire un right-click ensuite choisir créer des segements
          Get_PortfolioPlugin().ClickR();

          if(Get_PortfolioGrid_ContextualMenu_CreateSleeves().IsEnabled){
              Get_PortfolioPlugin().ClickR();
              Get_PortfolioPlugin().ClickR();
              Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();      
              //if(Get_DlgCroesus().Exists){//CP : Adaptation pour CO
              if(Get_DlgError().Exists){//CP : Adaptation pour CO
                Log.Checkpoint("Les segments pour le compte "+ account +"ont été créés")
                Get_DlgError().Close();
              }
              else{
                Log.Error("Les segments  pour le compte "+ account +"n'ont pas été créés")
              }
          }
          else{
            Log.Checkpoint("Les segments pour le compte "+ account +"ont été créés")
          } 
         
          //Fermer l'application
          Close_Croesus_AltQ();
          if(Get_DlgConfirmation().Exists){
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
          }   
      }
      catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
          //Débloquer le rééquilibrage
         Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
      }
      finally {
          Terminate_CroesusProcess(); //Fermer Croesus
          Driver.Next(); // Goes to the next record
      }         
  }
}





//*************************************************************************************************************************
//*********************************************FUNCTIONS*******************************************************************
/*Description : dans le module portefeuille, clique sur le btn By Asset Class, selection tous ce qu’est dans la grille, 
clique sur création de segments dans le menu contextuel ( par la clique droit).*/
function CreateSleeveByAssetClass()
{
    // grouper par classe d'actif
    Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
    //sélectionner tous les regroupement
    Get_Portfolio_Tab(1).Click();
    Get_Portfolio_Tab(1).Keys("^a");
    //faire un right-click ensuite choisir créer des segements
    Get_PortfolioPlugin().ClickR();

    if(Get_PortfolioGrid_ContextualMenu_CreateSleeves().IsEnabled){
        Get_PortfolioPlugin().ClickR();
        Get_PortfolioPlugin().ClickR();
        Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
        //if(Get_DlgCroesus().Exists){//CP : Adaptation pour CO
        if(Get_DlgError().Exists){//CP : Adaptation pour CO
          Log.Checkpoint("Les segments ont été créés")
          Get_DlgError().Close();
        }
        else{
          //Cliquer sur le bouton sauvegarder de la fenêtre de Gestionnaire des segments 
          Get_WinManagerSleeves_BtnSave().Click(); 
        }
    }
    else{
      Log.Checkpoint("Les segments ont déjà été créés")
    } 
    
         
}

function DragAccountToPortfolio(account)
{
    // mailler le compte  vers le module portefeuille  
    Log.Message("Drag the relationship No " + account + " to the Portfolio module.");
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", account, 10).Click();
    Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", account, 10),  Get_ModulesBar_BtnPortfolio());
}



//Ajout d'un modele au segment 
function InsertModelWinEditSleeve(model)
{
    //Cliquer sur le bouton Edit    
    Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
   
    //Mettre le modéle 
    Get_WinEditSleeve_TxtValueTextBox().Keys(model);
    Get_WinEditSleeve_BtnQuickSearchListPicker().Click();
    Get_WinEditSleeve_BtOK().Click();
}

//Valide que le modèle a été ajouté au segment
function CheckThatModelBindedToSleeve( description,model)
{
   var count =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count;
   for (var i = 1; i < count; i++){          
          if(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description==description){

              //if(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ModelName==model){
              if(aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "ModelName",cmpContains,model)){
                Log.Message(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ModelName)
                Log.Checkpoint("The Sleeve was modified")
              }
              else{
                Log.Error("The Sleeve was not modified")
              }
              break;
          }        
    }
}

//Décoche l’objectif de placement dans la fenêtre Info
function UncheckInvestmentObjectiveWinInfo(account)
{
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", account, 10).Click();
    Get_AccountsBar_BtnInfo().Click();
    Get_WinAccountInfo_TabInvestmentObjective().Click();
    Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount().Set_IsChecked(false);
    aqObject.CheckProperty(Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount(), "IsChecked", cmpEqual, false);
    Get_WinAccountInfo_BtnOK().Click();
}


function Delete_AllSleeves_WinSleevesManager()
{   
    //Cliquer sur le bouton segment
    Get_PortfolioBar_BtnSleeves().Click();
    var numberOftries=0;  
    while ( numberOftries < 5 && !Get_WinManagerSleeves().Exists){
      Get_PortfolioBar_BtnSleeves().Click();
      numberOftries++;
    } 
    Get_WinManagerSleeves().Parent.Maximize();  
    
    count =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count;
    
    if(count>1){
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Keys("^a");
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsSelected(false);
        
        // CP : Remplacé par les deux lignes précédentes car la logique ne fonctionne pas toujours (problème déjà rencontré avant les versions CO)
        /*
        for (var i = 0; i < count; i++){ 
              if(i==0){
                Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsSelected(false);             
              }
              else{
                Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsSelected(true);  
              }                  
        }
        */
        // CP : Remplacé par les deux lignes précédentes car ne fonctionne pas toujours (problème déjà rencontré avant les versions CO)
         
        Get_WinManagerSleeves().Click();
    
        //Cliquer sur le bouton Supprimer
        Get_WinManagerSleeves_GrpSleeves_BtnDelete().Click();
        
        if(!Get_DlgConfirmation().VisibleOnScreen){
          Get_WinManagerSleeves_GrpSleeves_BtnDelete().Click();
        } 
     
        var messageText = Get_DlgConfirmation_LblMessage().Message;
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    }
    
    aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual, 1);
    
    //Sauvgarder
    Get_WinManagerSleeves_BtnSave().Click();
    return messageText;
}
