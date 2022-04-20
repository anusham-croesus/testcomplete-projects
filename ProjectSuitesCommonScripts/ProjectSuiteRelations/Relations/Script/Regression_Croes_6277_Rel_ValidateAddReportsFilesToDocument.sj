//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT ExcelUtils


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6277
       
    Description :Valider l'ajout de document de type rapport.
            
    Auteur : Asma Alaoui
    
    ref90-10-Fm-13--V9-croesus-co7x-1_5_1_572
    
    Date: 27/05/2019
*/


function Regression_Croes_6277_Rel_ValidateAddReportsFilesToDocument()
{
  try{

    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6277", "Croes-6277");
    var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","COPERN","username");
		var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
		var AddNewRel_6277 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "AddNewRel_6277", language+client);
		var ClientId_6277 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "ClientId_6277", language+client);
		var reportName_6277 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "reportName_6277", language+client);
		var namePDF = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "namePDF", language+client);
		var Destination = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "Destination", language+client);
//		var FS800054 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "FS800054", language+client);   
//		var JJ800054 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "JJ800054", language+client);
//		var JW800054 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "JW800054", language+client);
//		var RE800054 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "RE800054", language+client);
    
		Login (vServerRelations,userNameCOPERN,passwordCOPERN, language);
	 
		
    Log.Message("Sélectionner le Module Relation");
		Get_ModulesBar_BtnRelationships().Click();
		Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    Get_MainWindow().Maximize();
      
    Log.Message("Créer la relation");
	 	CreateRelationship(AddNewRel_6277);    
		
    Log.Message("Chercher la relation crée et faire Clic-Droit");
		SearchRelationshipByNo(AddNewRel_6277) 
     
		Get_Toolbar_BtnAdd().Click();
		Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship().Click();
		//WaitObject(Get_CroesusApp(),"Uid","PickerBase_dcbf"); 
        
    Log.Message("Dans la liste, choisir un client  No.800303");		
		Get_WinPickerWindow_DgvElements().Keys("."); 
		Get_WinQuickSearch_TxtSearch().SetText(ClientId_6277);
		Get_WinQuickSearch_BtnOK().Click();
		Get_WinPickerWindow_BtnOK().Click();
		Delay(2000);
		Get_WinAssignToARelationship_BtnYes().Click();
  
    Log.Message("Click sur le bouton Rapports et graphiques");	
		Get_Toolbar_BtnReportsAndGraphs().Click(); 
		SelectReports(reportName_6277);
    Log.Message("Sélectionnez dans la zone options la destination: Fichier PDF - PDF File");
		Get_WinReports_GrpOptions_CmbDestination().Click();
		Delay(1000);
		SelectComboBoxItem(Get_WinReports_GrpOptions_CmbDestination(), Destination);
    Log.Message("Check l'option Archiver les rapports");
		
		Get_WinReports_GrpOptions_ChkArchiveReports().Click(); 
		Delay(1000);
    Log.Message("Click sur le bouton OK pour génèrer le rapport");
    Get_WinReports_BtnOK().WaitProperty("IsEnabled", true, 5000);
		Get_WinReports_BtnOK().Click();
     //La fenêtre des rapports devrait disparaître après 5 secondes au maximum
    if (!WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", Get_WinReports().Title.OleValue], 5000)){
        //Si la fenêtre des rapports est encore affichée, vérifier s'il y a eu affichage de la boîte de dialogue Validation et attendre qu'elle disparaisse le cas échéant
        if (WaitObject(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", "Validation"], 2000))
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", "Validation"], 60000);
    }       
    WaitObject(Get_CroesusApp(),["Uid", "VisibleOnScreen"], ["CRMDataGrid_3071",true], maxWaitTime);
    WaitObject(Get_CroesusApp(),"Uid","ToolbarButton_9b3d", 30000);
    Get_Toolbar_BtnSearch().WaitProperty("IsEnabled", true, 30000);
		    
		SearchRelationshipByNo(AddNewRel_6277);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071",maxWaitTime);
    
    Log.Message("Sélectionner la relation " + AddNewRel_6277 + " et faire double click Info / tab Documents");		
		Get_RelationshipsClientsAccountsGrid().FindChild("Value", AddNewRel_6277, 10).Click();
    Get_RelationshipsBar_BtnInfo().Click();    
		Get_WinDetailedInfo_TabDocuments().Click();
     
		
		
		var Compare = aqObject.CheckProperty(Get_WinDetailInfo_TabDocu_LvwDocuNameLabel(), "Text", cmpEqual, namePDF);
		if (Compare == true)
		{
		  Log.Message("The report is available " + namePDF);
		}
		else {
	  
		Log.Message("Error");
		}
		
		Get_WinDetailedInfo_BtnOK().Click();
    
  }
     catch(e) 
     {
       Log.Error("Exception: " + e.message, VarToStr(e.stack));
     }
  finally 
  {
    Terminate_CroesusProcess();
    Login (vServerRelations,userNameCOPERN,passwordCOPERN, language);
    Get_ModulesBar_BtnRelationships().Click();
    DeleteRelationship(AddNewRel_6277);
    Terminate_CroesusProcess();
  }   

}



