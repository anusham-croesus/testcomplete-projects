//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C2_Create_Sleeves_Via_InvestmentObjective
//USEUNIT CR1037_C1MO1_Edit_Sleeve
//USEUNIT CR1037_C1MO5_Edit_Sleeve

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C2MO9_Edit_Sleeve()
{
      try{   
         var user= ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username");  
         var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C2MO9", language+client); 
         var investmentObjective =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveGrowthSecurities", language+client);
         var sleeveFixedIncomeSecurities=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveFixedIncomeSecurities", language+client);
         var unallocated = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client); 
         var balance =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "PositionBalance", language+client);
         
         var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercent_C2MO9", language+client);
         var min=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercent_C2MO9", language+client);
         
         var newSleeveDescription=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtSleeveDescription_C2MO9", language+client);
         var targetAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercentAdhoc_C2MO9", language+client);
         var minAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercentAdhoc_C2MO9", language+client);
         var maxAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMaxPercentAdhoc_C1MO8", language+client);
         
         var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelRevenusFixes", language+client);
         var model1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelMoyenTerme", language+client);
         
         var quantityToMove=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "QuantityToMove_C2MO9", language+client);
         var quantityToMove2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "QuantityToMove2_C2MO9", language+client);
         
         var cveSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "CveSecurity_C2MO9", language+client);
         var cpSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "CpSecurity_C2MO9", language+client);
         
         var percentageToMoveCVE =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "PercentageToMoveCVE", language+client);
         var quantityToMoveCVE=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "QuantityToMoveCVE", language+client);
         var quantityToMoveCP =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AuantityToMoveCP", language+client);
         
         Login(vServerSleeves, user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
         
         Search_Account(account);
         AddInvestmentObjectiveItemBasicItemGlobalGrowth();
                     
         CreateSleeveForAccount(account,investmentObjective)
         
         //2-Modifier cibles :40% Cible de la sleeve 'Titre de croissance'                                                            
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",investmentObjective,100).Click();  
         
         Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
 
         var numberOftries=0;  
         while ( numberOftries < 5 && !Get_WinEditSleeve().Exists){
            Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();;
            numberOftries++;
         }
         
         AddEditSleeveWinSleevesManager("","",target,min,"","") 
         
         //******************************************Vérification*************************************************
         //a- La sleeve 'Titre de croissance' est disponible
         //b- la cible de la sleeve 'Titre de croissance' est 60%.
         Check_MinMaxTarget_of_Sleeve(min,"",target,newSleeveDescription)
         Check_RemainingTargetPercent();
         //*******************************************************************************************************
         
         //3-Ajouter une sleeve classe d'actif 'Titres à revenus fixes' et la nomee 'Titres à revenus fixes'
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(sleeveFixedIncomeSecurities,sleeveFixedIncomeSecurities,"","","","") 
         Log.Picture(Sys.Desktop.ActiveWindow(), "Screenshot", "Extended Message Text", pmHighest);//screenshot
         
         //******************************************Vérification*************************************************
         //c-sleeve 'Titres à revenus fixes' est disponible.
          if(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveFixedIncomeSecurities,10).Exists){
            Log.Checkpoint("Le segment est disponible")
         }
         else{
            Log.Error("Le segment n'est pas disponible")
         }
         //*******************************************************************************************************
                 
         //4- Ajouter un sleeve Adhoc ADH C2MO9  : 25% Cible, 5Min , 45 Max
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(newSleeveDescription,"",targetAdhoc,minAdhoc,maxAdhoc,"") 
                 
         //******************************************Vérification*************************************************
         //d-sleeve:ADH C2MO9 est disponible : 25% Cible, 5Min , 45 Max
         Check_MinMaxTarget_of_Sleeve(minAdhoc,maxAdhoc,targetAdhoc,newSleeveDescription)
         //*******************************************************************************************************
         
         //5-Ajouter un Modéle:'CH REVENUS FIXES' à la sleeve Titres à revenus fixes.          
         SelectSleeveWinSleevesManager(sleeveFixedIncomeSecurities);
         Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
         AddEditSleeveWinSleevesManager("","","","","",model) 
         
         //******************************************Vérification*************************************************
         //Modéle'CH REVENUS FIXES' est relié à la sleeve Titres à revenus fixes         
         CheckThatModelBindedToSleeve(sleeveFixedIncomeSecurities,model)
         //*******************************************************************************************************
                 
         //Ajouter le modéle 'CH MOYEN TERME' à la sleeve ADH C2MO9
         SelectSleeveWinSleevesManager(newSleeveDescription);
         Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
         AddEditSleeveWinSleevesManager("","","","","",model1) 
         //*******************************************************************************************************
         
         //******************************************Vérification*************************************************
         //le modéle 'CH MOYEN TERME' à la sleeve ADH C2MO9.        
         CheckThatModelBindedToSleeve(newSleeveDescription,model1)
         //*******************************************************************************************************
         
         /*7-Transférer deux positions de la sleeve Titres de croissance vers la sleeve  ADH C2MO9 :
         -CP % à déplacer 10% Qte= 44
         -CVE% à déplacer 100%  Qte=665*/
         SelectSleeveWinSleevesManager(investmentObjective);     

         var quantityToMoveCPBefore = Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Find("Text",cpSecurity,10).DataContext.DataItem.DisplayQuantity
             
         var securityDescription = Select_UnderlyingSecurities_WinSleevesManager(2);
         Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();
         Get_WinMoveSecurities_CmbToSleeve().Keys(newSleeveDescription);
         
         Get_WinMoveSecurities_GrpSecurities_DgvListView().Find("Text",cveSecurity,10).DataContext.set_PercentageToMove(percentageToMoveCVE);
         Get_WinMoveSecurities_GrpSecurities_DgvListView().Find("Text",cpSecurity,10).DataContext.set_QuantityToMove(quantityToMoveCP);
         
         Get_WinMoveSecurities().Click();
         Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
         Get_WinMoveSecurities_BtnOk().Click(); 
         
         Get_WinManagerSleeves_BtnSave().Click();         
         Delay(1500);
         //******************************************Vérification*************************************************
         //g- on a Qte:44 de CV et Qte:665 de CVE  dans la sleeve ADH C2MO9 
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",newSleeveDescription,100).Click();     
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Find("Text",cpSecurity,10).DataContext.DataItem, "DisplayQuantity", cmpEqual, quantityToMoveCP);  
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Find("Text",cveSecurity,10).DataContext.DataItem, "DisplayQuantity", cmpEqual, quantityToMoveCVE); 
         
         //et dans la sleeve Titres de croissance ont diminué
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",investmentObjective,100).Click(); 
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Find("Text",cpSecurity,10).DataContext.DataItem, "DisplayQuantity", cmpEqual, quantityToMoveCPBefore - quantityToMoveCP); 
         Check_NonPresence_of_Security_in_Sleeve(investmentObjective,cveSecurity) 

         //*******************************************************************************************************
                  
         //8-Transférer le cash entre les sleeves :de 'Divers' vers ' 'Titre de croissance'100$
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click();  
         var displayQuantityAvant = Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.DisplayQuantity  
         //Selectioner la solde
         Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",balance,10);                
         Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();  
         //Changer la quantité a transfère         
         Get_WinMoveSecurities_GrpSecurities_DgvListView().Items.Item(0).set_QuantityToMove(quantityToMove)
         Get_WinMoveSecurities_CmbToSleeve().Keys(investmentObjective);
         Get_WinMoveSecurities().Click();
         Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
         Get_WinMoveSecurities_BtnOk().Click();
         //******************************************Vérification*************************************************
         //h-Le cash de la sleeve 'Titre de croissance' à augmenté de 100$ et la sleeve Divers a diminué de 100$.
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click();     
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "DisplayQuantity", cmpEqual, displayQuantityAvant-quantityToMove);
         
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",investmentObjective,100).Click();     
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "DisplayQuantity", cmpEqual, quantityToMove);
         //*******************************************************************************************************
         
         //9-Transférer le cash entre les sleeves :' 'Titre de croissance' vers  la sleeve 'ADH C2MO9' 50$.
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",investmentObjective,100).Click();  
         var displayQuantityAvant = Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.DisplayQuantity  
         //Selectioner la solde
         Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",balance,10);                
         Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();  
         //Changer la quantité a transfère         
         Get_WinMoveSecurities_GrpSecurities_DgvListView().Items.Item(0).set_QuantityToMove(quantityToMove2)
         Get_WinMoveSecurities_CmbToSleeve().Keys(newSleeveDescription);
         Get_WinMoveSecurities().Click();
         Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
         Get_WinMoveSecurities_BtnOk().Click();
         //******************************************Vérification*************************************************
         //i- Le cash de la sleeve 'Titre de croissance' à diminué de 50$ et la sleeve 'ADH C2MO9' a augmenté de 50$.
        
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",investmentObjective,100).Click();     
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "DisplayQuantity", cmpEqual, displayQuantityAvant-quantityToMove2);
         
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",newSleeveDescription,100).Click();     
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "DisplayQuantity", cmpEqual, quantityToMove2);              
         Get_WinManagerSleeves().Close();   
          //*******************************************************************************************************
          
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

function AddInvestmentObjectiveItemBasicItemGlobalGrowth()
{
   Get_AccountsBar_BtnInfo().Click();
   Get_WinAccountInfo_TabInvestmentObjective().Click();
   Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
   Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_Growth().Click();  
   Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_Growth().Click();   
   Get_WinSelectAnObjective_BtnOK().Click();
   Get_WinDetailedInfo_BtnOK().Click();
}
