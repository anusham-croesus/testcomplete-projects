//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions

/* Description : A partir du module « Relations » , afficher la fenêtre « Sommation des titres » en cliquant sur MenuBar - btnSum. 
 Vérifier la présence des contrôles et des étiquetés */

function Survol_Rel_MenuBar_EditSum()
{
  Login(vServerRelations,userName,psw,language);
  Get_ModulesBar_BtnRelationships().Click();
    
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Sum().Click();
    
  //Les points de vérification 
  Check_Properties(language)
        
  Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar();
}

//Fonctions  (les points de vérification pour les scripts qui testent Sum)
function Check_Properties(language)
{
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum(), "Title", cmpEqual, GetData(filePath_Relations,"Sum",2,language));
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "Content", cmpEqual, GetData(filePath_Relations,"Sum",3,language));
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "IsEnabled", cmpEqual, true);
  
    aqObject.CheckProperty(Get_WinRelationshipsSum_LblAssetUnderManagement(), "Text", cmpEqual, GetData(filePath_Relations,"Sum",4,language));
    //aqObject.CheckProperty(Get_WinRelationshipsSum_LblWarningMessage(), "WPFControlText", cmpMatches, GetData(filePath_Relations,"Sum",5,language));
    if (language == "french"){
        aqObject.CheckProperty(Get_WinRelationshipsSum_LblWarningMessage(), "WPFControlText", cmpMatches, "(Les valeurs peuvent inclure des comptes non visibles par l\'utilisateur courant.\r\nCertains comptes peuvent être calculés en double s\'ils sont présents dans plusieurs relations.)");
    }
    else {
        aqObject.CheckProperty(Get_WinRelationshipsSum_LblWarningMessage(), "WPFControlText", cmpMatches, "(The values may include some accounts that are not accessible by the current user.\r\nSome accounts may be calculated more than once if they are included in many relationships.)");
    }
    
    if (client == "US" ){
        aqObject.CheckProperty(Get_WinRelationshipsSum_LblTotalCAD(), "Content", cmpEqual, GetData(filePath_Relations,"Sum",9,language));   
    }
    else if (client == "BNC"){
        aqObject.CheckProperty(Get_WinRelationshipsSum_LblTotalCAD(), "Content", cmpEqual, GetData(filePath_Relations,"Sum",10,language));
    }
    else {
        aqObject.CheckProperty(Get_WinRelationshipsSum_LblTotalCAD(), "Content", cmpEqual, GetData(filePath_Relations,"Sum",6,language));
    }
    
    aqObject.CheckProperty(Get_WinRelationshipsSum_LblTotalValueForRelationships(), "Content", cmpEqual, GetData(filePath_Relations,"Sum",7,language));
    aqObject.CheckProperty(Get_WinRelationshipsSum_TxtTotalValueForRelationshipsTotalCAD(), "IsVisible", cmpEqual,true);
  
    aqObject.CheckProperty(Get_WinRelationshipsSum_LblNumberOfRelationships(), "Content", cmpEqual, GetData(filePath_Relations,"Sum",8,language));
    aqObject.CheckProperty(Get_WinRelationshipsSum_TxtNumberOfRelationshipsTotalCAD(), "IsVisible", cmpEqual, true);  
}