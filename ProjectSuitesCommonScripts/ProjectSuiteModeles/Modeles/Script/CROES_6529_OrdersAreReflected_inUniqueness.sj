//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Jira BNC-2240 Des ordres sont reflétés en quadruple et plus à l'étape des ordres à éxécuter
    
    Lien sur TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6529
    Lien sur Jira : https://jira.croesus.com/browse/BNC-2240
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-19
*/

function CROES_6529_OrdersAreReflected_inUniqueness()
{
    try {
                
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var account300012NA = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "Account300012NA", language+client);        
        var segmentADHOC1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SegmentADHOC1_6529", language+client);
        var segmentADHOC2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SegmentADHOC2_6529", language+client);
        var segmentADHOC3 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SegmentADHOC3_6529", language+client);
        var modeleCanadianEquity = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ModeleCanadianEquity", language+client);
        var modeleCHBonds = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ModeleCHBonds", language+client);
        var modeleCHLongTerm = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ModeleCHLongTerm", language+client);
        var targetADHOC1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetADHOC1_6529", language+client);
        var targetADHOC2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetADHOC2_6529", language+client);
        var targetADHOC3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetADHOC3_6529", language+client);
              
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6529","Cas de test TestLink : Croes-6529")
        Log.Link("https://jira.croesus.com/browse/BNC-2240","Lien sur Jira : BNC-2240")
               
        //Login
        Log.Message("************************************** Login *********************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
        
        //Mailler le compte 300012-NA vers module Portefeuille 
        Log.Message("Mailler le compte "+account300012NA+" vers module Portefeuille") 
        Search_Account(account300012NA);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account300012NA,10), Get_ModulesBar_BtnPortfolio());
        
        Log.Message("Cliquer sur le bouton Segment");
        Get_PortfolioBar_BtnSleeves().Click();
        Get_WinManagerSleeves().Parent.Maximize();
        
        //**Ajouter les 3 segments
        Log.Message("Ajout de segment "+segmentADHOC1+" modèles = "+modeleCHBonds+" %Cible = "+targetADHOC1)
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(segmentADHOC1,"",targetADHOC1,"","",modeleCHBonds)
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_df77");
        
        Log.Message("Ajout de segment "+segmentADHOC2+" modèles = "+modeleCanadianEquity+" %Cible = "+targetADHOC2)
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(segmentADHOC2,"",targetADHOC2,"","",modeleCanadianEquity)                  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_df77");
        
        Log.Message("Ajout de segment "+segmentADHOC3+" modèles = "+modeleCHLongTerm+" %Cible = "+targetADHOC3)
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(segmentADHOC3,"",targetADHOC3,"","",modeleCHLongTerm)                  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_df77");
        
        Get_WinManagerSleeves_BtnSave().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        //**
         
        //Rééquilibrer jusqu'a étape 4
        Log.Message("Cliquer sur Synchroniser et laisser cocher la case Rééquilibrer le compte -- Rééquilibrer jusqu'a étape 4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalancingMethod().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}         
        Get_WinRebalancingMethod_BtnOK().Click();
         
        WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");                                                      
        Get_WinRebalance().Parent.Maximize();
        
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click(); 
        
        if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        }           
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
             
        //3- A l'étape 3 du rééquilibrage ==> Cliquez sur  bouton Grouper  
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
        
        Get_WinRebalance_BtnNext().Click();         
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        Log.Message("Valider que la fenêtre d'ordre affiche les ordres en unicité. Il n'y a  pas d'ordre affiché en double.")
        CheckOrdersUniqueness();
        
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        /*Log.Message("************************************** CLEANUP *********************************************")
        //**Supprimer les 3 segments  
        RestoreData(segmentADHOC1,segmentADHOC2,segmentADHOC3)
        
                
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();*/
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {
		    Log.Message("************************************** CLEANUP *********************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
        
        //Mailler le compte 300012-NA vers module Portefeuille 
        Log.Message("Mailler le compte "+account300012NA+" vers module Portefeuille") 
        Search_Account(account300012NA);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account300012NA,10), Get_ModulesBar_BtnPortfolio());
        
        RestoreData(segmentADHOC1,segmentADHOC2,segmentADHOC3)
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Runner.Stop(true)
    }
}

function CheckOrdersUniqueness(){
  
  var nbOfLines = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Count;
  var reflectedOrders = new Array();
  var errorMessage ="";
  var nbError = 0;
  
  for(i =0; i<nbOfLines; i++){
    var searchOrder = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SecurityDescription.OleValue
    if(array_search(searchOrder,reflectedOrders)== -1)
      reflectedOrders.push(searchOrder);
    else
    {
      if(aqString.Find(errorMessage, searchOrder)== -1){ //pour qu'il ne compte pas le même ordre doublé +eurs fois
        nbError++;
        errorMessage += searchOrder+"\n";
      }      
    }
  }
  
  if(nbError != 0)
    Log.Error(nbError+" ordre(s) est/sont reflété(s) en double et plus à l'étape des ordres à éxécuter. (voir additional info)",errorMessage)
  else
    Log.Checkpoint("la fenêtre d'ordre affiche les ordres en unicité. Il n'y a  pas d'ordre affiché en double.")
}

 
function RestoreData(segmentADHOC1,segmentADHOC2,segmentADHOC3){
  Log.Message("Cliquer sur Segment et Supprimer les 3 segment par le bouton Supprimer Puis Sauvegarder");
  Get_PortfolioBar_BtnSleeves().Click();
  Get_WinManagerSleeves().Parent.Maximize();
        
  Log.Message("** Supprimer le segment "+segmentADHOC1)
  DeleteSleeveWinSleevesManager(segmentADHOC1)
  WaitObject(Get_CroesusApp(), "Uid", "DataGrid_df77");
        
  Log.Message("** Supprimer le segment "+segmentADHOC2)
  DeleteSleeveWinSleevesManager(segmentADHOC2)
  WaitObject(Get_CroesusApp(), "Uid", "DataGrid_df77");
        
  Log.Message("** Supprimer le segment "+segmentADHOC3)
  DeleteSleeveWinSleevesManager(segmentADHOC3)
  WaitObject(Get_CroesusApp(), "Uid", "DataGrid_df77");
        
  //Sauvgarder
  Get_WinManagerSleeves_BtnSave().Click();
  WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
}

