//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT ExcelUtils

/* Description : A partir du module « Titre » , afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters. 
 Vérifier la présence des contrôles et des étiquetés */
 
 function Survol_Tit_MenuBar_btnQuickFilters_AddFilter()
 {
    Login(vServerTitre, userName , psw ,language);
    Get_ModulesBar_BtnSecurities().Click();
    
    Get_MenuBar_Search().OpenMenu();
    Get_MenuBar_Search_QuickFilters().OpenMenu();
    Get_MenuBar_Search_QuickFilters_AddAFilter().Click();
    
    Check_Properties(language)
            
    Get_WinAddFilter_BtnCancel().Click();
      
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 
 //Fonctions  (les points de vérification pour les scripts qui testent Add_Filter)
function Check_Properties(language)
{    
    //Vérification des textes 
    aqObject.CheckProperty(Get_WinAddFilter().Title, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",1,language))
   
    aqObject.CheckProperty(Get_WinAddFilter_BtnOK().Content.Text, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",2,language));      
    aqObject.CheckProperty(Get_WinAddFilter_BtnCancel().Content.Text, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",3,language));
    aqObject.CheckProperty(Get_WinAddFilter_LblDescription().Content, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",4,language));
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition().Header, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",5,language));

    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_LblField().Content, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",6,language));
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_LblOperator().Content, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",7,language));
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_LblValue().Content, "OleValue", cmpEqual, GetData(filePath_Titre,"Add_Filter",8,language));  
    
    //Vérification de contrôles 
    aqObject.CheckProperty(Get_WinAddFilter_TxtDescription(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_TxtDescription(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_CmbField(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_CmbField(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_CmbOperator(), "IsVisible", cmpEqual, true);  
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_CmbOperator(), "IsEnabled", cmpEqual, true); 
       
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_TxtValue(), "IsVisible", cmpEqual, true);  
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_TxtValue(), "IsEnabled", cmpEqual, true);
      
    aqObject.CheckProperty(Get_WinAddFilter_BtnLanguages(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_BtnLanguages(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAddFilter_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_BtnOK(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAddFilter_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_BtnCancel(), "IsEnabled", cmpEqual, true); 
    
}

