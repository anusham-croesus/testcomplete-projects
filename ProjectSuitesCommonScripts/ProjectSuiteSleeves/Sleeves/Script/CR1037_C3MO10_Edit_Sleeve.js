//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C3_Create_FromSleevesManager_Via_InvestmentObjective
//USEUNIT CR1037_C1MO1_Edit_Sleeve

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C3MO10_Edit_Sleeve()
{
      try{  
        
         var user= ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username");  
         var sleeveCanadianEquity = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client); 
         var investmentObjective=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationGrowth", language+client);
         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C3", language+client);             
         var sleeveLongTerm = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client); 
         
         var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercent_C3MO10", language+client); 
         
         var targetLongTerm=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercentLongTerm_C3MO10", language+client);
         var minLongTerm=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercentLongTerm_C3MO10", language+client);
         var maxLongTerm=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMaxPercentLongTerm_C3MO10", language+client);
         
         var newSleeveDescription=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtSleeveDescription_C3MO10", language+client);
         var targetAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercentAdhoc_C3MO10", language+client);
         var minAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercentAdhoc_C3MO10", language+client);
         var maxAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMaxPercentAdhoc_C3MO10", language+client);
         var model =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);
         
         
         Login(vServerSleeves, user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
                     
         CreateSleeveForAccount(account,sleeveCanadianEquity)
         
         
         //2-Modifier cibles :40% Cible de la sleeve 'Actions cannadiennes'
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveCanadianEquity,100).Click();  
         
         Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
          
          var numberOftries=0;  
         while ( numberOftries < 5 && !Get_WinEditSleeve().Exists){
            Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();;
            numberOftries++;
         }
         
         AddEditSleeveWinSleevesManager("","",target,"","","") 
         
         //******************************************Vérification*************************************************
         /*a- La sleeve 'Actions cannadiennes' est disponible
         b-La cible de la sleeve 'Actions cannadiennes' est 40% et le champ '% restant de la cible'=60%.*/
         Check_MinMaxTarget_of_Sleeve("","",target,newSleeveDescription)
         Check_RemainingTargetPercent();
         //*******************************************************************************************************
                  
         //3-Ajouter une sleeve classe d'actif 'Long terme' avec la description 'Long terme'.
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(sleeveLongTerm,sleeveLongTerm,targetLongTerm,minLongTerm,maxLongTerm,"") 
                  
         //4- Ajouter un sleeve Adhoc ADH C3MO10  : 10% Cible, 5Min , 15 Max
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(newSleeveDescription,"",targetAdhoc,minAdhoc,maxAdhoc,"") 
                          
         //5-Ajouter un Modéle'CH LONG TERM'à la sleeve 'Long terme' .
         SelectSleeveWinSleevesManager(newSleeveDescription);
         Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
         AddEditSleeveWinSleevesManager("","","","","",model)        
         
         //6-Supprimer la sleeve 'Actions cannadiennes' et OK.
         DeleteSleeveWinSleevesManager(sleeveCanadianEquity)
         
         Get_WinManagerSleeves_BtnSave().Click();
          //******************************************Vérification*************************************************
          Get_PortfolioBar_BtnSleeves().Click();
         //Get_WinManagerSleeves().Parent.Maximize(); 
         
         //c-La sleeve  'Long terme' est disponible:25% Cible, 5Min , 45 Max
         Check_MinMaxTarget_of_Sleeve(minLongTerm,maxLongTerm,targetLongTerm,sleeveLongTerm)

         //d- Sleeve:ADH C3MO10 disponible : 10% Cible, 5Min , 15Max  le champ '% restant de la cible'=40%.
         Check_MinMaxTarget_of_Sleeve(minAdhoc,maxAdhoc,targetAdhoc,newSleeveDescription)

         //e- Modéle'CH LONG TERM' est relié à la sleeve 'Long terme'.
          CheckThatModelBindedToSleeve(newSleeveDescription,model)

         //f-La sleeve 'Actions cannadiennes' n'est plus disponible.
         //g- Le champ '% restant de la cible' sera = 65% de le segment.
         if(CheckPresenceOfSleeveWinSleevesManager(sleeveCanadianEquity)){
            Log.Error("Le segment n'est pas présent dans le gestionnaire des segments")
         }
         else{
            Log.Checkpoint("Le segment est présent dans le gestionnaire des segments")
          }
         
         Check_RemainingTargetPercent();
         Get_WinManagerSleeves().Close();

         //********************************************Remettre les données a l'êtas initial***********************
         //********************************************************************************************************    
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