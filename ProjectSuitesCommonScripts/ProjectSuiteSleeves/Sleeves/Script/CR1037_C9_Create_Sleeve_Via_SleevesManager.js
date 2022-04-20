//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective


 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C9_Create_Sleeve_Via_SleevesManager()
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
         AddEditSleeveWinSleevesManager(assetClass,assetClass,target,min,max,"")
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
         Check_RemainingTargetPercent();
                            
         Get_WinManagerSleeves().Close();
                                             
         //********************************************Remettre les données a l'êtas initial***************************************************************************
         //************************************************************************************************************************************************************    
         //Supprimer des segments 
         Delete_AllSleeves_WinSleevesManager();  
                
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