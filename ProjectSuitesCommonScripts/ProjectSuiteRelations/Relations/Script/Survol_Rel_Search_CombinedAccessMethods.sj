//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints



function Survol_Rel_Search_CombinedAccessMethods(){
       
     try{
            var waitTime = 3000;
            
            Login(vServerRelations, userName, psw, language);
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime); 
            
            //afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search
            Get_MenuBar_Edit().OpenMenu();
            Get_MenuBar_Edit_Search().Click();
            Get_WinQuickSearch().WaitProperty("VisibleOnScreen", true, waitTime);
            Get_WinQuickSearch_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_2b91", waitTime);
  
            //afficher la fenêtre « Rechercher » en tapant la lettre 'F'
            Get_MainWindow().Keys("F");
            Get_WinQuickSearch().WaitProperty("VisibleOnScreen", true, waitTime);
            Get_WinQuickSearch_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_2b91", waitTime);
  
            //afficher la fenêtre « Rechercher » en cliquant sur Toolbar - btnSearch
            Get_Toolbar_BtnSearch().Click();
            Get_WinQuickSearch().WaitProperty("VisibleOnScreen", true, waitTime);
            
            //Les points de vérification 
            Check_Properties(language)
  
            Get_WinQuickSearch_BtnCancel().Click();

            } catch (e) {      
                  //S'il y a exception, en afficher le message
                  Log.Error("Exception: " + e.message, VarToStr(e.stack));
  
            } finally { 
                  Terminate_CroesusProcess();
            }    
}

function Check_Properties(language){
  
          aqObject.CheckProperty(Get_WinQuickSearch(), "Title", cmpEqual, GetData(filePath_Relations,"Search",2,language));
          aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "Content", cmpEqual, GetData(filePath_Relations,"Search",3,language));
          aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsEnabled", cmpEqual, true);
   
          aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "Content", cmpEqual, GetData(filePath_Relations,"Search",5,language));
          aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsEnabled", cmpEqual, true);
  
          aqObject.CheckProperty( Get_WinQuickSearch_LblSearch(), "Text", cmpEqual, GetData(filePath_Relations,"Search",6,language));
          aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsEnabled", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinQuickSearch_LblIn(), "Text", cmpEqual, GetData(filePath_Relations,"Search",4,language));
  
          aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoRelationshipNo().DataContext, "Label", cmpEqual, GetData(filePath_Relations,"Search",7,language));
          aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoRelationshipNo(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoRelationshipNo(), "IsEnabled", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoName().DataContext, "Label", cmpEqual, GetData(filePath_Relations,"Search",8,language));
          aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoName(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoName(), "IsEnabled", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoIACode().DataContext, "Label", cmpEqual, GetData(filePath_Relations,"Search",9,language));
          aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoIACode(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoIACode(), "IsEnabled", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoCurrency().DataContext, "Label", cmpEqual, GetData(filePath_Relations,"Search",10,language));
          aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoCurrency(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoRelationshipNo(), "IsEnabled", cmpEqual, true);    
}