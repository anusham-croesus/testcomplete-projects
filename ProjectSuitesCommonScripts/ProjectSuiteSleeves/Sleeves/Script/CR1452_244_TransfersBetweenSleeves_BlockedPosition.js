//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_244_TransfersBetweenSleeves_BlockedPosition()
{
    try{ 
                
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var account= GetData(filePath_Sleeves, "DataPool_WithModel", 4); //800291-GT
        var positionBWR=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionBWR", language+client);
        var adhocSleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinEditSleeveTxtSleeveDescription_244", language+client);      
        var sleeveCanadianEquity =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        //Sélectionner la position 'TRP' (Transcanada) et mettre comme position bloquée dans Info Portefeuille et OK
        Search_Position(positionBWR)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionBWR),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        //Valider que les positions sont bloquées   
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionBWR,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
              
        //ajouter un segment Adhoc
        Get_PortfolioBar_BtnSleeves().Click();           
        Get_WinManagerSleeves().Parent.Maximize(); 
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(adhocSleeveDescription,"","","","","")   
        
        //Transférer le BWR du segment 'Actions Canadiennes' vers le segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveCanadianEquity,100).Click();   
        //Selectioner le BWR
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",positionBWR,10).Click();  
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();
        Get_WinMoveSecurities_CmbToSleeve().Keys(adhocSleeveDescription);                  
        Get_WinMoveSecurities().Click();
        Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
        Get_WinMoveSecurities_BtnOk().Click();
                  
        //Valider que la position a été transféré
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveCanadianEquity,100).Click(); 
        if (Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",positionBWR,10).Exists){
          Log.Error("la position n'a pas été transféré");
        } else{
          Log.Checkpoint("la position a été transféré");
        }
         
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",adhocSleeveDescription,100).Click(); 
        if (Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",positionBWR,10).Exists){
          Log.Checkpoint("la position a été transféré");
        } else{
          Log.Checkpoint("la position n'a pas été transféré");
        } 
        
        Get_WinManagerSleeves_BtnCancel().CLick();
       
        //Réinitialiser les données
        Search_Position(positionBWR)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionBWR),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionBWR,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
                    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();       
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());       
        //Réinitialiser les données 
        Search_Position(positionTRP)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionBWR),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionBWR,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus 
    }
}