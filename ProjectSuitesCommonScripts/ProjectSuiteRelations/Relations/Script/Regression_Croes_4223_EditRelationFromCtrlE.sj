//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT DBA


/*
Croes-4223: Modifier une relation
Module: Relations / Sélectionner la relation et cliquer sur CTRL + E  
    
Modifier une relation à partir CTRL + E

Auteur :  Jimenab
Analyste Manuel : antonb
Version de scriptage:	90-10-Fm-6

*/
function Regression_Croes_4223_EditRelationFromCtrlE() 
{   
  try 
  {
		
	  var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "COPERN", "username");
    var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
    var relationshipNameKey = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"Regression","relationshipNameKey", language+client);
    var updatedFullName_Ctrl = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"Regression","updatedFullName_Ctrl", language+client);
          
    //Se connecter à Croesus avec copern
    Login(vServerRelations, userNameCOPERN, passwordCOPERN,language);
    Get_MainWindow().Maximize();
    //Sélectionner le Module Relation
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);      
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
            
                
    //************** "Ajouter une relation" à partir du bouton Add (++) 
    Get_Toolbar_BtnAdd().Click();
    Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click()
           
    //Remplir les informations de la fenêtre et appuyer sur le bouton "Ok" pour créer une nouvelle relation
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameKey)
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(relationshipNameKey);
    Get_WinDetailedInfo_BtnOK().Click();
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
     
    //Chercher la relation  
    SearchRelationshipByNo(relationshipNameKey); 
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
          
    Log.Message("Select '" + relationshipNameKey + "' relationship.");
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameKey, 10).Click();
          
    //Keys("^e"); //CTRL + E
    Get_RelationshipsClientsAccountsGrid().Keys("^e");
    WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["TabItem", "Info"]); //Attendre TabInfo
    WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"]); //Attendre TxtFullName
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(updatedFullName_Ctrl);
    Get_WinDetailedInfo_BtnOK().Click();
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
                
    //Chercher la relation  
    SearchRelationshipByNo(relationshipNameKey); 
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
      
    //Valider la modification     
    Get_RelationshipsBar_BtnInfo().Click();
    WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["TabItem", "Info"]); //Attendre TabInfo
    WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"]); //Attendre TxtFullName
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "Text", cmpEqual, updatedFullName_Ctrl);
    Get_WinDetailedInfo_BtnOK().Click();
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");      
      
  }
    
    catch (e)
	{
		Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    
    finally 
	{
     DeleteRelationship(relationshipNameKey); 
     Terminate_CroesusProcess();  
    }
  
}