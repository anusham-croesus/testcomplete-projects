//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective


 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C9_C10_C14_CreationSegments_WithDifferentOptions_And_ValidationDeletionMessage()
{
      try{  

         var user= ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "COPERN", "username");
         var assetClass = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveCmbAssetClassMaturityEquity", language+client);
         var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationFinancialInstrument", language+client);
         var unallocated = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
         var account = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C9", language+client);
         var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercent_C9", language+client);
         var min=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercent_C9", language+client);
         var max=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMaxPercent_C9", language+client);
         var message= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "DlgCroesusLblMessage_C10", language+client);
         var sleeveDescription =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtSleeveDescription_C10", language+client);   
        
         var account_C14= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C14", language+client);   
         var assetAllocation_C14 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationAllocationMaturity", language+client);;
         
         var assetClass_C14=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveCmbAssetClassMaturityBetween3", language+client);        
         var target_C14=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercent_C14", language+client); 
         var min_C14=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercent_C14", language+client); 
         var max_C14=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMaxPercent_C14", language+client); 
         
         var assetClass_1_C14=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveCmbAssetClassMaturityBetween5", language+client); 
         var target_1_C14=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercent1_C14", language+client); 
         var min_1_C14=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercent1_C14", language+client); 
         var max_1_C14=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMaxPercent1_C14", language+client); 
         
         
         
         Login(vServerSleeves,user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
         
         
         
         Search_Account(account);
         
         DragAccountToPortfolio(account); 
         
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().WaitProperty("VisibleOnScreen",true,1500)
         Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation().set_Text(assetAllocation) 
         
         //a) on peut sélectionner une autre répartition l'option n'est pas grisée
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "IsEnabled", cmpEqual,true);
          
         //Get_WinManagerSleeves().Parent.Maximize();
         
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(sleeveDescription,assetClass,target,min,max,"")
         Log.Picture(Sys.Desktop.ActiveWindow(), "Screenshot", "Extended Message Text", pmHighest);//screenshot
         
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(assetClass_C14,assetClass_C14,target_C14,min_C14,max_C14,"")
         Log.Picture(Sys.Desktop.ActiveWindow(), "Screenshot", "Extended Message Text", pmHighest);//screenshot 
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(assetClass_1_C14,assetClass_1_C14,target_1_C14,min_1_C14,max_1_C14,"")
         Log.Picture(Sys.Desktop.ActiveWindow(), "Screenshot", "Extended Message Text", pmHighest);//screenshot
         
         //b) Le champ 'Répartition d'actifs' devient  'Instrument financier' et est grisé, on ne peut pas sélectionner autre chose dans la liste déroulante.
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "Text", cmpEqual, assetAllocation);
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "IsEnabled", cmpEqual,false);
         
         Get_WinManagerSleeves_BtnSave().Click(); 
         Delay(1500);
           
                                          
         //******************************************Vérification******************************************************************************************  
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();
         
         //c) Le champs 'Description de le segment'= 'Action', % Cible=10, Min=10, Max=20.
         Check_MinMaxTarget_of_Sleeve(min,max,target,assetClass)
         //d) Le champ '% restant de la cible' sera = 100-10=90% de le segment.
         //c) Le champs 'Description de le segment' 'Échéance entre3 et 4 ans' , % Cible=20, Min=10, Max=25.
         Check_MinMaxTarget_of_Sleeve(min_C14,max_C14,target_C14,assetClass_C14)
         //d)le champs 'Description de le segment' 'Échéance entre 5 et 10 ans' , % Cible=10, Min=10, Max=20
         Check_MinMaxTarget_of_Sleeve(min_1_C14,max_1_C14,target_1_C14,assetClass_1_C14)
         
         Check_RemainingTargetPercent();
         
         Get_WinManagerSleeves().Close(); 
           
    
         //Supprimer les segments et valider le message de suppression
         Delete_AllSleeves_WinSleevesManager_And_ValidateDeletionMessage(message)

   
                
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
    }
    finally {
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

//Supprimer tous les segments crées
function Delete_AllSleeves_WinSleevesManager_And_ValidateDeletionMessage(message)
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
        Get_WinManagerSleeves().Click();    
        //Cliquer sur le bouton Supprimer
        Get_WinManagerSleeves_GrpSleeves_BtnDelete().Click();
        
        if(!Get_DlgConfirmation().VisibleOnScreen){
          Get_WinManagerSleeves_GrpSleeves_BtnDelete().Click();
        } 
        aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual, message); 
        var messageText = Get_DlgConfirmation_LblMessage().Message;
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    }
    
    aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual, 1);
    
    //Sauvgarder
    Get_WinManagerSleeves_BtnSave().Click();
    return messageText;
}