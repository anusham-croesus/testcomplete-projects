//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective
//USEUNIT CR1037_C1MO1_Edit_Sleeve

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C1MO5_Edit_Sleeve()
{
      try{  

         var user= ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username"); 
         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C1MO5", language+client);
         var sleeveToDelete = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveMediumTerm", language+client);  
         var unallocated = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client); 
         var sleeveLongTerm = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);           
         var balance =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "PositionBalance", language+client); 
         var newSleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtSleeveDescription_C1MO5", language+client);
         
         var quantityToMove=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "QuantityToMove_C1MO5", language+client);         
         var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercent_C1MO5", language+client);
         var min=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercent_C1MO5", language+client);
         var max=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMaxPercent_C1MO5", language+client);
                    
         Create_Sleeve_ForAccount_withGlobalBalancedAssetAllocation(account) 
         
        if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Exists && Get_PortfolioGrid_GrpSummary_ChkFundAllocation().VisibleOnScreen){
            if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().IsChecked){
            Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Click()
            }
         }
                                                 
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         //Supprimer le segment "Moyen terme"
         DeleteSleeveWinSleevesManager(sleeveToDelete)  
               
         //b-Le champ '% restant de la cible = 20% de le segment.
         Check_RemainingTargetPercent();
                         
         //Ajout de segment Adhoc
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(newSleeveDescription,"",target,min,max,"")   
         
         //Transférer deux positions de la sleeve 'Long terme' vers 'ADH C1MO5'.
         SelectSleeveWinSleevesManager(sleeveLongTerm);         
         var securityDescription = Select_UnderlyingSecurities_WinSleevesManager(2);
         Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();
         Get_WinMoveSecurities_CmbToSleeve().Keys(newSleeveDescription);
         
         Get_WinMoveSecurities().Click();
         Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
         Get_WinMoveSecurities_BtnOk().Click();        
                 
         //Transférer le cash 150$ de la sleeves Divers vers la sleeve 'ADH C1MO5' 
          Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click();   
         //Selectioner la solde
         Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",balance,10);                
         Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();  
         //Changer la quantité a transfère         
         Get_WinMoveSecurities_GrpSecurities_DgvListView().Items.Item(0).set_QuantityToMove(quantityToMove)
         Get_WinMoveSecurities_CmbToSleeve().Keys(newSleeveDescription);
         
         Get_WinMoveSecurities().Click();
         Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
         Get_WinMoveSecurities_BtnOk().Click();
         
         Get_WinManagerSleeves_BtnSave().Click();         
         Delay(1500);
               
         //******************************************Vérification******************************************************************************************************
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
                          
         //a- La sleeve 'Moyen terme' n'est plus disponible dans la fenêtre 'gestionnaire de segments'.
          //Verification
         if(CheckPresenceOfSleeveWinSleevesManager(sleeveToDelete)){
            Log.Error("Le segment n'est pas présent dans le gestionnaire des segments")
         }
         else{
            Log.Checkpoint("Le segment est présent dans le gestionnaire des segments")
          }
         
         //c- La sleeve:ADH C1MO5 est disponible
         if(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",newSleeveDescription,10).Exists){
            Log.Checkpoint("Le segment est disponible")
         }
         else{
            Log.Error("Le segment n'est pas disponible")
         }
         
         //d- Les valeurs sont :% Cible=20, Min =15 , Max=35
         Check_MinMaxTarget_of_Sleeve(min,max,target,newSleeveDescription)
         
         //e- Les deux positions sont disponible dans la sleeve ADH C1MO5 et ne le sont plus dans la sleeve Moyen terme.
         Check_Presence_of_Security_in_Sleeve(newSleeveDescription,securityDescription)
         Check_NonPresence_of_Security_in_Sleeve(sleeveLongTerm,securityDescription)
         
         //f- Le cash de la sleeve 'ADH C1MO5' à augmenté de 150$ et la sleeve Divers a diminué de 150$.
         Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",newSleeveDescription,100).Click();     
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "DisplayQuantity", cmpEqual, quantityToMove); 
         
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

function Select_UnderlyingSecurities_WinSleevesManager(nbrOfSecuritiesToSelect)
{
    //var countGrigManager =Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Count;
    var securityDescription=new Array();
    
    for(var i=0;i<=nbrOfSecuritiesToSelect ;i++){
             //Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsSelected(false);
             //Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsActive(false);
             Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
             securityDescription[i]= Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SecurityDescription
             //Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true)      
         }
         
      Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Keys(" ");
      return securityDescription;
}

//La fonction vérifie in WinSleevesManager 
function Check_Presence_of_Security_in_Sleeve(sleeveDescription,securityDescription)
{   
     Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveDescription,100).Click();  
     var count =Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Count; 
     for(var i=0; i<count; i++){    
       if(VarToString(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SecurityDescription)== VarToString(securityDescription[i])){
          Log.Checkpoint("La security"+ securityDescription[i] +" est présente dans le segment")
       }
       else{
          Log.Error("La security "+ securityDescription[i] +"n'est pas présente dans le segment")       
       }
     }      
}

function Check_NonPresence_of_Security_in_Sleeve(sleeveDescription,securityDescription)
{   
     Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveDescription,100).Click();  
     var count =Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Count; 
     var lengthArray=securityDescription.length
     for(var j=1; j<lengthArray; j++){
       for(var i=0; i<count; i++){    
         if(VarToString(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SecurityDescription)== VarToString(securityDescription[j])){
            Log.Error("La security"+ securityDescription[j] +" est présente dans le segment")
         }
       }

       Log.Checkpoint("La security "+ securityDescription[j] +"n'est pas présente dans le segment")       
     }     
}

