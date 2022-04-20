//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables

/* Description : :Création d'un filtre rapide temporaire dont la valeur est une date
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1041
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1041_Cli_Create_TempDateFilter_ToolBar_btnQuickFilters()
 {
   try{
    var filtre = GetData(filePath_Clients, "CR1352", 9, language);
 
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
       
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
   Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
   Get_Toolbar_BtnQuickFilters_ContextMenu_Date().Click();
   Get_Toolbar_BtnQuickFilters_ContextMenu_Date_DateOfBirth().Click();
   Log.Message("******************* Étape 3 *******************")
   /*Cliquer sur Appliquer : Un message s'affiche :
                             Vous devez indiquer une valeur */
   Get_WinCreateFilter_BtnApply().Click();
   //Les points de vérifications:
   aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"CR1352",398,language));
   Get_DlgInformation_BtnOK().Click();
   
    
   
   //Création d'un filtre
   Get_WinCreateFilter_CmbOperator().DropDown();
   Get_WinCRUFilter_CmbOperator_ItemOnOrPriorTo().Click();
   Get_WinCreateFilter_DtpValue().set_StringValue(filtre);
   Get_WinCreateFilter_BtnApply().Click();
   
   //Les points de vérification
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients,"CR1352",10,language));
   
   //Vérifier le nombre de clients dans la grille et le compare avec le nombre de clients dans la fenêtre sommation
   Compare_SumGrid_clientNumber();
    /*Cliquer sur le cryon et modifier la date de naissance 

      valeur : date du jour ( 31/01/2020) puis Appliquer:
      Résultat :
      Le filtre  date de naissance=01/31/2020 est  appliquée (Orang)

      la grille est vide , aucun résultat n'est affiché      

      */ 
                              
     // Cliquer sur le crayon
     Log.Message("************* Étape : 6   ***********************")    
      var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
      Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-35, 13);
          if(language == "french")
            {
            var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d")
            }
            if(language == "english")
            {
              var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y")
            }
      Get_WinCreateFilter_CmbOperator().DropDown();
      Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();      
      Get_WinCreateFilter_DtpValue().set_StringValue(ToDay);
      Get_WinCreateFilter_BtnApply().Click(); 
      // Les points de vérifications
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl, "HasItems", cmpEqual, false);
      //Cliquer sur X pour enlever le filtre 
        Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnRemove(1).Click();
      
  

  }
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
   }
   finally{
   
         Terminate_CroesusProcess();
   }       
  } 
 