//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective
//USEUNIT CR1037_C1MO5_Edit_Sleeve

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C1MO8_Edit_Sleeve()
{
      try{
       
         var user= ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username");   
         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C1MO8", language+client); 
         var message2 =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "DlgCroesusLblMessage_C1MO8", language+client);

         var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationBalanced", language+client); //Equilibre (Objectif)
         var assetAllocation2 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationIncomeAndGrowth", language+client);
         var sleeveAmericanEquity =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveCmbAssetClassAmericanEquity", language+client);
         
         var newSleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtSleeveDescription_C1MO8", language+client);
         var model =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelMoyenTerme", language+client);       
         var min =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercent_C1MO8", language+client);
         var max =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercent_C1MO8", language+client);
         var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMaxPercent_C1MO8", language+client);
         
         //C1         
         Create_Sleeve_ForAccount_withGlobalBalancedAssetAllocation(account) 
                         
         //Modifier l'objectif de placement (à partir de compte) puis OK
         Get_ModulesBar_BtnAccounts().Click();
         Search_Account(account);
         
         Get_AccountsBar_BtnInfo().Click();
         Get_WinAccountInfo_TabInvestmentObjective().Click();
         Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
         Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_IncomeAndGrowth().Click();  
         Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_IncomeAndGrowth().Click();  
         Get_WinSelectAnObjective_BtnOK().Click();
         Get_WinDetailedInfo_BtnOK().Click();
        
        //**********************************Vérification:****************************************************************
        /*a- Message:''Vous tentez de modifier ou supprimer l'objectif d'investissement d'un compte qui détient des segments. 
        Les segments ne seront pas modifiées en fonction du nouvel objectif d'investissement. Voulez-vous continuer?"*/
        if(Get_DlgConfirmation().Exists){
           if(language=="english"){
              aqObject.CheckProperty(Get_DlgConfirmation(), "CommentTag", cmpEqual, "You are trying to modify or delete the investment objective of an account that includes sleeves.\r\nNote that the sleeves will not be modified according to the selected investment objective.\r\nDo you want to continue?" );
              //Le fichier Excel n'a pas marché dans ce cas 
           }
           else{
              aqObject.CheckProperty(Get_DlgConfirmation(), "CommentTag", cmpEqual, "Vous tentez de modifier ou de supprimer l'objectif de placement d'un compte qui contient des segments.\r\nNotez que les segments ne seront  pas modifiés en fonction de l'objectif de placement sélectionné.\r\nVoulez-vous continuer?" );
              //Le fichier Excel n'a pas marché dans ce cas 
           }
           Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
           //Get_DlgCroesus_BtnOK().Click();// CP : Changé par la ligne précédente pour CO
        }
        else{
            Log.Error("Il n'y a pas de message")
        }
        //************************************************************************************************************** 
         
         DragAccountToPortfolio(account); 
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
                      
         //Ajout de segment Adhoc
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
                  
         AddEditSleeveWinSleevesManager(newSleeveDescription,"","","","",model)   
         
         Get_WinManagerSleeves_BtnSave().Click(); 
         Delay(1500)
         
         //**********************************Vérification:****************************************************************
         /*b- sleeve:ADH C1MO8 disponible
         c- Modèle 'CH MOYEN TERME'relié*/
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         
         CheckThatModelBindedToSleeve(newSleeveDescription,model)
         
         if(CheckPresenceOfSleeveWinSleevesManager(newSleeveDescription)){
              Log.Checkpoint("Le segment est présent dans le gestionnaire des segments")
         }
         else{
              Log.Error("Le segment n'est pas présent dans le gestionnaire des segments")
         }
         //d-objectif de placement lorsqu'on ajout adhoc  'Equilibre (Objectif)'
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "Text", cmpEqual, assetAllocation);
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "IsEnabled", cmpEqual,false);
         Get_WinManagerSleeves().Close();  
         //***************************************************************************************************************
         
         //Supprimer toutes les sleeves 
         var messageText= Delete_AllSleeves_WinSleevesManager(); 
         //**********************************Vérification:****************************************************************
         //e- Message: "Si vous supprimez cette branche:
         aqObject.CompareProperty(messageText,cmpEqual,message2)
         //***************************************************************************************************************
         
         //Ajouter une sleeve 'Action américaine' basé sur asset classe
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();                 
         AddEditSleeveWinSleevesManager(sleeveAmericanEquity,sleeveAmericanEquity,"","","","")  
         Get_WinManagerSleeves_BtnSave().Click(); 
         Delay(1500)
         //**********************************Vérification:****************************************************************
         //f- Vérifier que l'objectif de placement devient  'revenu et croissance' et  grisé
         //g-Ajout une sleeve  'Action américaine'  .%cible=10 et  % restant =90.
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "Text", cmpEqual, assetAllocation2);
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "IsEnabled", cmpEqual,false);
         
         Check_MinMaxTarget_of_Sleeve(min,max,target,sleeveAmericanEquity)
         Check_RemainingTargetPercent(); 
         
         Get_WinManagerSleeves().Close();  
         //***************************************************************************************************************
                                              
         //********************************************Remettre les données a l'êtas initial******************************
         //***************************************************************************************************************    
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
