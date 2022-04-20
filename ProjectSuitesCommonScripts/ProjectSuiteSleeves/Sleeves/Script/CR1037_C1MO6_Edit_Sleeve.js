//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective
//USEUNIT CR1037_C1MO5_Edit_Sleeve

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C1MO6_Edit_Sleeve()
{
      try{  

         var user= ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username");   
         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C1MO6", language+client); 
         var sleeveMediumTerme = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveMediumTerm", language+client);   
         var unallocated = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);  
         var sleeveCanadianEquity = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);  
         
         var balance =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "PositionBalance", language+client); 
         
         var quantityToMove1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "QuantityToMove_C1MO6", language+client);
         var quantityToMove2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "QuantityToMove1_C1MO6", language+client);
         var newSleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtSleeveDescription_C1MO6", language+client);

                    
         Create_Sleeve_ForAccount_withGlobalBalancedAssetAllocation(account) 
         
         if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Exists && Get_PortfolioGrid_GrpSummary_ChkFundAllocation().VisibleOnScreen){
            if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().IsChecked){
            Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Click()
            }
         }
                                                 
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();                
                         
         //Ajout de segment Adhoc
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(newSleeveDescription,"","","","","")   
         
         //Transférer deux positions de la sleeve 'Moyen terme' vers 'ADH C1MO6'.
         SelectSleeveWinSleevesManager(sleeveMediumTerme);         
         var securityDescription = Select_UnderlyingSecurities_WinSleevesManager(2);
         Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();
         Get_WinMoveSecurities_CmbToSleeve().Keys(newSleeveDescription);
         
         Get_WinMoveSecurities().Click();
         Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
         Get_WinMoveSecurities_BtnOk().Click(); 
         
         Get_WinManagerSleeves_BtnSave().Click();         
         Delay(1500);
         
         //**********************************Vérification:****************************************************************
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
                                   
         //e- Les deux positions sont disponible dans la sleeve ADH C1MO6 et ne le sont plus dans la sleeve Moyen terme.
         Check_Presence_of_Security_in_Sleeve(newSleeveDescription,securityDescription)
         Check_NonPresence_of_Security_in_Sleeve(sleeveMediumTerme,securityDescription)       
         //***************************************************************************************************************
          
         //Transférer le cash entre les sleeves :de 'Divers' vers 'Action Canadiennes'100$       
          Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click();  
          var displayQuantityAvant = Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.DisplayQuantity 
         //Selectioner le solde
         Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",balance,10);                
         Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();  
         //Changer la quantité a transfère         
         Get_WinMoveSecurities_GrpSecurities_DgvListView().Items.Item(0).set_QuantityToMove(quantityToMove1)
         Get_WinMoveSecurities_CmbToSleeve().Keys(sleeveCanadianEquity);
         
         Get_WinMoveSecurities().Click();
         Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
         Get_WinMoveSecurities_BtnOk().Click();
         Get_WinManagerSleeves_BtnSave().Click();         
         Delay(1500);
         
         //***************************************************************************************************************
         //Vérification:Le cash de la sleeve 'Action Canadiennes' à augmenté de 100$ et la sleeve Divers a diminué de 100$.
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveCanadianEquity,100).Click();     
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "DisplayQuantity", cmpEqual, quantityToMove1);
         
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click();     
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "DisplayQuantity", cmpEqual, displayQuantityAvant-quantityToMove1);
         //****************************************************************************************************************
         
         //Transférer le cash entre les sleeves :'Action Canadiennes' vers  la sleeve 'Moyen terme' 50$.
          Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveCanadianEquity,100).Click();  
          var displayQuantityAvant = Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.DisplayQuantity 
         //Selectioner le solde
         Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",balance,10);                
         Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();  
         //Changer la quantité a transfère         
         Get_WinMoveSecurities_GrpSecurities_DgvListView().Items.Item(0).set_QuantityToMove(quantityToMove2)
         Get_WinMoveSecurities_CmbToSleeve().Keys(sleeveMediumTerme);
         
         Get_WinMoveSecurities().Click();
         Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
         Get_WinMoveSecurities_BtnOk().Click();
         Get_WinManagerSleeves_BtnSave().Click();         
         Delay(1500);
         
          //********************************************************************************************************************        
         //Vérification: Le cash de la sleeve 'Action Canadiennes' à diminué de 50$ et la sleeve 'Moyen terme' a augmenté de 50$.
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveCanadianEquity,100).Click();     
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "DisplayQuantity", cmpEqual, displayQuantityAvant-quantityToMove2);
         
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveMediumTerme,100).Click();     
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "DisplayQuantity", cmpEqual, quantityToMove2);
         //***********************************************************************************************************************    
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

