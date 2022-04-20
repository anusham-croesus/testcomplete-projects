//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT ExcelUtils


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4220
       
    Description :Ajouter une restriction à une relation
            
    Auteur : Asma Alaoui
    
    ref90-10-Fm-13--V9-croesus-co7x-1_5_1_572
    
    Date: 22/05/2019
*/

function Regression_Croes_4220_Rel_AddRestrictionToRelationShip()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4220", "Croes-4220");
     
     var relationship00000=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "Relationship00000", language+client);
     var valeur=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "SecurityValue", language+client);
     var description=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "DesSecurity", language+client);
     var devise=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "Currency", language+client);
     var restriction=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "Restriction", language+client);  
    
    
    //Accès au module Relations
    Login(vServerRelations, userName,psw,language);
    Get_ModulesBar_BtnRelationships().Click();   
    Get_MainWindow().Maximize();
    
    //Sélectionnert la relation "00000" 
    SearchRelationshipByNo(relationship00000);
   
    //Cliquer sur le bouton Restriction
    Get_RelationshipsAccountsBar_BtnRestrictions().Click();
    
    //Ajouter une restriction et valider le champ "DISNEY WALT COMPANY"
    Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
    Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().SetText(valeur);
    Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]"); 
    aqObject.CompareProperty(Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Text, cmpEqual, description, true)
    
    //Cocher "Devise du prix" et dans la liste déroulante du paramètre "N’égale pas" sélectionner CAD.
    Get_WinCRURestriction_GrpSecurity_RdoPriceCurrency().Click();
    Get_WinCRURestriction_GrpSecurity_CmbPriceCurrencyNotEqualTo().Click();
    Get_SubMenus().Find("WPFControlText",devise,10).Click();
    Get_WinCRURestriction_BtnOK().Click();
    
    //Valider l'icône "Verte" et la sévérité ''Non bloquante''
    ValidateSeverity();
    
    //Fermer le gestionnaire de restrictions
    Get_WinRestrictionsManager_BtnClose().Click();
    
    //Sélectionner de nouveau la même relation et valider l'affichage de la restriction
    SearchRelationshipByNo(relationship00000);
    Get_RelationshipsAccountsBar_BtnRestrictions().Click();
    var restrictonDisplay= Get_WinRestrictionsManager_DgvRestriction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1]).DataContext.DataItem.Description.OleValue
    aqObject.CompareProperty(restrictonDisplay, cmpEqual, restriction, true)
    
    
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    Login(vServerRelations, userName,psw,language);
    Get_ModulesBar_BtnRelationships().Click()
    SearchRelationshipByNo(relationship00000);
    Get_RelationshipsAccountsBar_BtnRestrictions().Click();
    DeleteRestriction(restriction)
    Terminate_CroesusProcess();
    
  }      

}

function ValidateSeverity()

{
    var severity=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "severity", language+client);
    aqObject.CheckProperty(Get_WinRestrictionsManager(),"Exists",cmpEqual, true);
    aqObject.CheckProperty(Get_WinRestrictionsManager(),"IsVisible",cmpEqual, true);
    
     if (Get_WinRestrictionsManager().Find("Text", severity ,10).Exists && Get_WinRestrictionsManager().Find("WPFControlText", "Respected",10).Exists)
    
    {
      Log.Checkpoint("La restriction ne rentre pas en conflit avec les positions détenues par le compte")
    }
     else
    {
      Log.Error("La restriction n'est pas respectée");
    } 
     
}
