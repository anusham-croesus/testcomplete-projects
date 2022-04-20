//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT CR1709_2662_Check_New_Columns

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2925
Analyste d'automatisation: Youlia Raisper */



function CR1709_2925_Check_New_Columns(){
  
  try{  
        Activate_Inactivate_Pref("GP1859", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "3", vServerModeles)
        //Activate_Inactivate_PrefFirm("Firm_1", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "3", vServerModeles)
        RestartServices(vServerModeles)
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");

        var FrequencyMonthly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyMonthly", language+client);
        var ColumnWithdrawalFrequency1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnWithdrawalFrequency1", language+client);
        var ColumnWithdrawalFrequency2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnWithdrawalFrequency2", language+client);
        var ColumnWithdrawalAmount1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnWithdrawalAmount1", language+client);
        var ColumnWithdrawalAmount2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnWithdrawalAmount2", language+client);
        var ColumnWithdrFreqStartDate1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnWithdrFreqStartDate1", language+client);
        var ColumnWithdrFreqStartDate2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnWithdrFreqStartDate2", language+client);
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2925","Cas de test TestLink : Croes-2925")  
                    
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
         //Vérification des entêtes de colonnes par défaut     
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
       
        //*********************************click droit sur la barre --> Ajouter une colonne         
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        if(FindColumnIn(ColumnWithdrawalFrequency1)){
          Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        } 
        Log.Message("Envoyé a Manel pour valider si c'est une anomalie")

        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        
        if(FindColumnIn(ColumnWithdrawalFrequency2)){
         Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        } 
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        if(FindColumnIn(ColumnWithdrawalAmount1)){
          Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        } 
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();       
        if(FindColumnIn(ColumnWithdrawalAmount2)){
         Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        } 
        
         Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        if(FindColumnIn(ColumnWithdrFreqStartDate1)){
          Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        } 
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();       
        if(FindColumnIn(ColumnWithdrFreqStartDate2)){
          Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        } 
                
        //*********************************click droit sur la barre --> Remplacer par
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ReplaceColumnWith().OpenMenu();        
        if(FindColumnIn(ColumnWithdrawalFrequency1)){
          Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        } 
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ReplaceColumnWith().OpenMenu();            
        if(FindColumnIn(ColumnWithdrawalFrequency2)){
         Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        } 
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ReplaceColumnWith().OpenMenu(); 
        if(FindColumnIn(ColumnWithdrawalAmount1)){
          Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        } 
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ReplaceColumnWith().OpenMenu();        
        if(FindColumnIn(ColumnWithdrawalAmount2)){
         Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        } 
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ReplaceColumnWith().OpenMenu(); 
        if(FindColumnIn(ColumnWithdrFreqStartDate1)){
          Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        } 
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ReplaceColumnWith().OpenMenu();        
        if(FindColumnIn(ColumnWithdrFreqStartDate2)){
          Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        }
                            
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus 
	    Runner.Stop(true);            
    }
}
