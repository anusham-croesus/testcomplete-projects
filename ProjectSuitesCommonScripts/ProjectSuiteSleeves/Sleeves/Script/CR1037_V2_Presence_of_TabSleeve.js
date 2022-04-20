//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_V2_Presence_of_TabSleeve()
{
      try{   
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LOTHC", "username");   
         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C1", language+client);             
         Create_Sleeve_ForAccount_withGlobalBalancedAssetAllocation(account) 
         
         if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Exists && Get_PortfolioGrid_GrpSummary_ChkFundAllocation().VisibleOnScreen){
            if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().IsChecked){
            Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Click()
            }
         }
         
         //Récupérer les segments qu’ont été crées de la fenêtre WinSleevesManager         
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();          
         var sleeveDescription = GetSleeveDescriptionWinSleevesManager()
         Get_WinManagerSleeves().Close();
         
         //Valider la présence des segments         
         Get_ModulesBar_BtnAccounts().Click();
         Search_Account(account);
         Get_AccountsBar_BtnInfo().Click();
         
         Get_WinAccountInfo_TabSleeves().Click();
         CompareSleevesDescription(sleeveDescription) 
          
         Get_WinAccountInfo().Close();
                                                
         //********************************************Remettre les données a l'êtas initial***************************************************************************
         //************************************************************************************************************************************************************    
         Get_ModulesBar_BtnPortfolio().Click();
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


function GetSleeveDescriptionWinSleevesManager()
{
     //Récupérer la description de chaque segment de la fenêtre Sleeves Manager
     var sleevesDescription=new Array();
     var countGrid = Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count 
     for(var i=0;i<=countGrid-1;i++){
       sleevesDescription[i]=Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description     
     } 
     return sleevesDescription;
}

/* La fonction valide la présence des segments  qu'ont été récupérés de la fenêtre Sleeves Manager 
dans la fenêtre Info */      
function CompareSleevesDescription(sleevesDescription)  
{      
     var countSleevesDescriptions = Get_WinAccountInfo_TabSleeves_DgvAccountSleeves().WPFObject("RecordListControl", "", 1).Items.Count;
     for(var i=0;i<=countSleevesDescriptions-1;i++){
         if(VarToString(Get_WinAccountInfo_TabSleeves_DgvAccountSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description)==VarToString(sleevesDescription[i])){
            Log.Checkpoint("Le segment ["+sleevesDescription[i]+"] est présent dans l'onglet Sleeves")
         }
         else{
            Log.Error("Le segment ["+sleevesDescription[i]+"] n'est pas présent dans l'onglet Sleeves")       
         }      
     }    
}