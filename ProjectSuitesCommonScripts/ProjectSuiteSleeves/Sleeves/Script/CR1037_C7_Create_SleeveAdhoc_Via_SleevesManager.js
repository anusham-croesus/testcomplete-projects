//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective


 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C7_Create_SleeveAdhoc_Via_SleevesManager()
{
      try{    

         var user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "COPERN", "username") 
         var sleeveDescription =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtSleeveDescription_C7", language+client);
         var unallocated = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C7", language+client);
         var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);  
         var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercent_C7", language+client);  
         var min=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercent_C7", language+client);  
         var max=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMaxPercent_C7", language+client);  
           
         Login(vServerSleeves, user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
                               
         Search_Account(account);
         
         DragAccountToPortfolio(account); 
         
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(sleeveDescription,"",target,min,max,model)
         Get_WinManagerSleeves_BtnSave().Click(); 
         Delay(1500);
           
                                          
         //******************************************Vérification******************************************************************************************  
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();
         
         //a) La fenêtre 'Gestionnaire des segments' s'affiche avec le segment adhoc 'ADH C7'(+ le segment divers)
         Check_Presence_of_Unallocated_and_OtherSleeve(sleeveDescription,unallocated)              
         //c) % Cible=25, Min=20, Max=30 sont affichés dans la fenêtre.
         Check_MinMaxTarget_of_Sleeve(min,max,target,sleeveDescription)
          //b)La colonne 'Asset class' sera vide (puisque c'est Adhoc) 
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem, "AssetAllocation", cmpEqual, null);                    
         //d)Le champ '% restant de la cible' sera 75% ( 100- %cible de le segment) .
         Check_RemainingTargetPercent()
          
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



