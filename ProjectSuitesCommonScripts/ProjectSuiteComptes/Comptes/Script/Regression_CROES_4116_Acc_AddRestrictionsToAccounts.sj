//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/**
    Description : Ajouter des restrictions à des comptes.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4116.
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version :ref90-10-Fm-6--V9
*/


function Regression_CROES_4116_Acc_AddRestrictionsToAccounts()
{
 try{
     Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4116","CROES_4116");
     var accountNo= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo_4116", language+client);
     var severity= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "severity", language+client);
     var bank= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "bank", language+client);
     var description= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "description", language+client);
     var devise= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "devise", language+client);
     var currency= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "currency", language+client);
     
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
    
    //Accès au module Comptes
    Get_ModulesBar_BtnAccounts().Click();
    
    //chercher le compte "30002-NA"
    SelectAccounts(accountNo);
    
    //Accèder à la fênetre "Restrictions"
    Get_RelationshipsAccountsBar_BtnRestrictions().Click();
    
    //Aller sur le bouton "Ajouter"
    Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
    
    //Recherche dans Titres "Banque de Montréal"
    //SearchSecurityInAddRestriction(description);    //Modifié par Amine A.
    Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().SetText(description);
    Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
    
    //Ajout de restiction avec "Pourcentage de la valeur totale" 
    AddRestrictionRdoModified(Get_WinCRURestriction_GrpSecurity_RdoPercentageOfTotalValue());
    
    //Valider l'icône "Verte"
    ValidateSeverity();
     
    //Sélectionner la restriction ajoutée
    Get_WinRestrictionsManager().Find("Text", severity ,10).Click();
     
    //Modifier la restriction
    Get_WinRestrictionsManager_BarPadHeader_BtnEdit().Click();
    
    //Ajout de restriction avec "Durée modifiée"
    AddRestrictionRdoModified(Get_WinCRURestriction_GrpSecurity_RdoModifiedDuration());
    
    //Valider l'icône "Verte" 
    ValidateSeverity(); 
      
    //Sélectionner la restriction ajoutée
     Get_WinRestrictionsManager().Find("Text", severity ,10).Click();
     
    //Modifier la restriction
    Get_WinRestrictionsManager_BarPadHeader_BtnEdit().Click();
       
    //Ajout de restriction avec "Devise du prix" et valider la sévérité    
    Get_WinCRURestriction_GrpSecurity_RdoPriceCurrency().Click();
    Get_WinCRURestriction_GrpSecurity_CmbPriceCurrencyNotEqualTo().Click();
    Get_SubMenus().Find("WPFControlText", devise, 10).Click();
    Get_WinCRURestriction_BtnOK().Click();
    
    //Valider l'icône "Verte" et la sévérité ''Non bloquante''
    ValidateSeverity();
        
    //Sélectionner la restriction ajoutée
    Get_WinRestrictionsManager().Find("Text", severity ,10).Click();
     
    //Modifier la restriction
    Get_WinRestrictionsManager_BarPadHeader_BtnEdit().Click();
    
    //Ajout de restriction "Groupe ou classe"    
    Get_WinCRURestriction_GrpGroupClass_RdoGroupClass().Click();
    Get_WinCRURestriction_GrpGroupClass_BtnClass().Click();
    Get_SubMenus().Find("Text", currency, 10).Click();
    Get_SubMenus().FindChild("Text", devise, 10).Click();
    Get_WinCRURestriction_GrpGroupClass_TxtPercentageOfTotalValueMinimum().Set_Text("50");
    Get_WinCRURestriction_GrpGroupClass_TxtPercentageOfTotalValueMaximum().Set_Text("90");
    Get_WinCRURestriction_BtnOK().Click();
    
    //Valider l'icône "Verte" et la sévérité ''Non bloquante''
    ValidateSeverity();
    
    //Fermer le gestionnaire de restrictions
   Get_WinRestrictionsManager_BtnClose().Click();
 
    }

 catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    } 
 finally {

    Log.Message("Delete restriction ");
    Get_ModulesBar_BtnAccounts().Click();
    SelectAccounts(accountNo);
    Get_RelationshipsAccountsBar_BtnRestrictions().Click();    
    DeleteRestriction(severity);
    Terminate_CroesusProcess();
    
    }

}
function DeleteRestriction(severity)
{
    Get_WinRestrictionsManager().Find("Text", severity ,10).Click();
    Get_WinRestrictionsManager_BarPadHeader_BtnDelete().Click();
    Get_DlgConfirmation_BtnDelete().Click();
    Get_WinRestrictionsManager_BtnClose().Click();

}

function AddRestrictionRdoModified(GetFunctionBtnRdo)
{
    GetFunctionBtnRdo.Click();
    Get_WinCRURestriction_BtnOK().Click();

}

function SearchSecurityInAddRestriction(description)
{
      var bank= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "bank", language+client);
    Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().SetText(description);
    Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]"); 
    Get_SubMenus().Find("Text", bank, 10).DblClick();
    
}
function ValidateSeverity()

{
     var severity= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "severity", language+client);
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
