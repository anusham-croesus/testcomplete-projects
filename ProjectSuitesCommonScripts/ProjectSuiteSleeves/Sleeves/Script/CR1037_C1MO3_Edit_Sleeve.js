//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective
//USEUNIT CR1037_C1MO1_Edit_Sleeve

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C1MO3_Edit_Sleeve()
{
      try{   
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username");   
         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C1", language+client);
         var sleeveDescription= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);
         var sleeveToDelete = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);
         var unallocated = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client); 
         var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);
                             
         Create_Sleeve_ForAccount_withGlobalBalancedAssetAllocation(account) 
         
         if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Exists && Get_PortfolioGrid_GrpSummary_ChkFundAllocation().VisibleOnScreen){
            if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().IsChecked){
            Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Click()
            }
         }
                                
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         
         //Supprimer le segment "Actions Canadiennes"
         DeleteSleeveWinSleevesManager(sleeveToDelete)
         
         //Ajouter un Modéle à la sleeve 'Long terme'
         SelectSleeveWinSleevesManager(sleeveDescription)
         
         Get_WinManagerSleeves_GrpSleeves_BtnEdit().WaitPoperty("IsEnabled",true,2000);
         Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
         
         AddEditSleeveWinSleevesManager("","","","","",model)
                           
         Get_WinManagerSleeves_BtnSave().Click(); 
         Delay(1500);
               
         //******************************************Vérification******************************************************************************************************        
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();   
         
         //a-Les segments (chaque branche correspond à une classe d'actif + le segment divers) sont disponible. 
         CheckAssertClassVsSleeves_WinSleevesManager();
         if(CheckPresenceOfSleeveWinSleevesManager(unallocated)){
             Log.Checkpoint("Le segment est présent dans le gestionnaire des segments")
         }
         else{
              Log.Error("Le segment n'est pas présent dans le gestionnaire des segments")
         }
            
         //b-Modéle CH LONG TERM à la sleeve 'Long terme'.
         CheckThatModelBindedToSleeve( sleeveDescription,model)
         //c-La sleeve Actions Canadiennes n'est plus disponible.
          //Verification
         if(CheckPresenceOfSleeveWinSleevesManager(sleeveToDelete)){
            Log.Error("Le segment n'est pas présent dans le gestionnaire des segments")
         }
         else{
            Log.Checkpoint("Le segment est présent dans le gestionnaire des segments")
          }
                          
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
        //Remettre les données a l'êtas initial dans le cas d'erreur 
        Login(vServerSleeves, user ,psw,language);
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

function CheckAssertClassVsSleeves_WinSleevesManager()
{
    var count =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count;
    
    for (var i = 1; i < count; i++){   
      
          if(VarToString(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description)==VarToString(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AssetAllocation.LongDescription)){
             Log.Checkpoint("Le segment correspond à une classe d'actif")
          } 
          else{
            Log.Error("Le segment ne correspond pas à une classe d'actif")
          }       
    }
}