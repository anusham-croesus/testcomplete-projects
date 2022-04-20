//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C1MO1_Edit_Sleeve()
{
      try{  
         
         var user= ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username");  
         var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C1", language+client);    
         var sleeveToDelete = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);
         var newSleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtSleeveDescription_C1MO1", language+client);
         var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);
         var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercent_C1MO1", language+client);
         var min=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercent_C1MO1", language+client);
         var max=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMaxPercent_C1MO1", language+client);
                    
         Create_Sleeve_ForAccount_withGlobalBalancedAssetAllocation(account) 
         
         if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Exists && Get_PortfolioGrid_GrpSummary_ChkFundAllocation().VisibleOnScreen){
            if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().IsChecked){
            Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Click()
            }
         }
                  
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         //Supprimer le segment "Long Terme"
         DeleteSleeveWinSleevesManager(sleeveToDelete)
        
         //b-Le champ '% restant de la cible = 20% de le segment. *  (La valeur sera affichée avant de créer le segment ADH C1MO1 )
         Check_RemainingTargetPercent();
         
         //Ajout de segment Adhoc
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(newSleeveDescription,"",target,min,max,model)                  
         Get_WinManagerSleeves_BtnSave().Click(); 
         Delay(1500);
               
         //******************************************Vérification******************************************************************************************************
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
          
         //a-La sleeve 'Long terme' n'est plus disponible dans la fenêtre 'gestionnaire de segments'.
         //Check_NonPresence_Of_Sleeve_WinSleevesManager(sleeveToDelete)
         //Verification
         if(CheckPresenceOfSleeveWinSleevesManager(sleeveToDelete)){
            Log.Error("Le segment n'est pas présent dans le gestionnaire des segments")
         }
         else{
            Log.Checkpoint("Le segment est présent dans le gestionnaire des segments")
          }

         //c- Sleeve:ADH C1MO1 est disponible.
         if(CheckPresenceOfSleeveWinSleevesManager(newSleeveDescription)){
              Log.Checkpoint("Le segment est présent dans le gestionnaire des segments")
         }
         else{
              Log.Error("Le segment n'est pas présent dans le gestionnaire des segments")
         }

         //d-Les valeurs sont :% Cible=15 , Min =10 , Max=30.
         Check_MinMaxTarget_of_Sleeve(min,max,target,newSleeveDescription)         
         //e- Le champ '% restant de la cible = 5% de le segment.
         Check_RemainingTargetPercent();         
         //f- Mobéle 'CH MOYEN TERME' relié à la sleeve ADH C1MO1      
         CheckThatModelBindedToSleeve( newSleeveDescription,model)
         
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

function CheckPresenceOfSleeveWinSleevesManager(description)
{
  //Sélectionner le segment
    var count =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count;
    var found=false;
    
    for (var i = 0; i < count; i++){          
          if(VarToString(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description)==VarToString(description)){
             found=true;
             break;
          }        
    }
    
   return found;
}