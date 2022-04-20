//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1153_Cli_Create_PerCurrencyFilter_Icon_Y
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT DBA

/* Description :Lorsque l'espace disponible n'est pas suffisant pour afficher  tous les filtres,
une barre de défilement scroll apparait sous la barre des filtres juste au dessus de la grille
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1451
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

function CR1352_1451_Cli_AddScroll_underFiltersBar()
{
  var logEtape1, logEtape2,logEtape3,logEtape4,logEtape6,logEtape7,logEtape8
  try{
      Log.Link("https://jira.croesus.com/browse/TCVE-1626");
      var filterValue="test";
           
      //******************************************* Étape 1***************************************************        
      logEtape1 = Log.AppendFolder("Étape 1: Se loguer a l'application ");
      
      var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
      var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
      Login(vServerClients, userNameKEYNEJ , passwordKEYNEJ ,language);
      Get_ModulesBar_BtnClients().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 1000);
      Get_MainWindow().Restore();
      
      
      //******************************************* Étape 2 , 3 , 4 , 5*****************************************
      Log.PopLogFolder(); 
      logEtape2 = Log.AppendFolder("Module Clients :Jira: CRM-3658"); 
      Log.Message("Les étaptes 2, 3, 4 ");
      Step2Step3Spet4("Clients");
      Terminate_CroesusProcess();
      
      Log.Message("L'étapte 5");
      Login(vServerClients, userNameKEYNEJ , passwordKEYNEJ ,language);
      Step5("Clients", Get_ModulesBar_BtnClients());
                
      //******************************************* Étape 8, 9, ************************************************
      Log.PopLogFolder(); 
      logEtape3 = Log.AppendFolder("Module Relations: Jira: CRM-3658"); 
      Get_ModulesBar_BtnRelationships().Click();
      Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 1000);
      Log.Message("Les étaptes 2, 3, 4 ");
      Step2Step3Spet4("Relations");
      Terminate_CroesusProcess();
      
      Log.Message("L'étapte 5");
      Login(vServerClients, userNameKEYNEJ , passwordKEYNEJ ,language);
      Step5("Relations", Get_ModulesBar_BtnRelationships());
      
      
      //******************************************* Étape 6 , 7 *************************************************
      Log.PopLogFolder();
      logEtape4 = Log.AppendFolder("Module Comptes :Jira: CRM-3658"); 
      Log.Message("Les étaptes 2, 3, 4 ");
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 1000);
      Step2Step3Spet4("Comptes");
      Terminate_CroesusProcess();
      
      Log.Message("L'étapte 5");
      Login(vServerClients, userNameKEYNEJ , passwordKEYNEJ ,language);
      Step5("Comptes", Get_ModulesBar_BtnAccounts());
      
        
      //******************************************* Étape 10***************************************************  
      Log.PopLogFolder();      
      logEtape4 = Log.AppendFolder("Étape 10: Tester l'affichage de la barre de scroll");
      
      Log.Message("Ajouter des filtres avec un nom qui contient le maximum de caractère jusqu'à est ce qu'on voit la barre de scroll"); 
      
      var arrStep10 = [];
      
      for (i=0; i<=4; i++) {
          var name="";
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          SetAutoTimeOut();
          if(!Get_SubMenus().Exists){
            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          }
          RestoreAutoTimeOut();
          Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
          Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click();
          for (j=0; j<=50; j++) {
              name = name+i;
          }
          var cmbField = GetData(filePath_Clients, "CR1352", 417+i, language);
          Get_WinCRUFilter_GrpDefinition_TxtName().Keys(name);
          //Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
          Get_WinCRUFilter_GrpCondition_CmbField().set_Text(cmbField);
          Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
          Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
          Get_WinCRUFilter_GrpCondition_TxtValue().Keys(filterValue);
          Get_WinCRUFilter_BtnOK().Click();
          Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().WaitProperty("IsEnabled", true, 5000);
          Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
          if (i==0){Get_DlgWarning().Close();}
          WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071",15000);

          arrStep10.push(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).Items.Item(i+4).get_FilterDescription());// +4 pour les filters A,B,C,D
      }
          
      for (i=0;i<=4;i++) {
         Log.Message(arrStep10[i]);
      }
       
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(arrStep10.length+4), "VisibleOnScreen", cmpEqual, false);
      Get_RelationshipsClientsAccountsGrid().Drag(60,35,400,0);
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(arrStep10.length+4), "VisibleOnScreen", cmpEqual, true);
  }
  catch(e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Log.Message("Supprimer les filtres")
    for (i=0;i<=4;i++) {
        Delete_FilterCriterion(arrStep10[i],vServerClients)//Supprimer les filtres de BD  
    }
    var arr = ["B","C","A","D"]
      for (i=0;i<4;i++) {
        Delete_FilterCriterion(arr[i],vServerClients)//Supprimer les filtres de BD  
      };
    //Fermer le processus Croesus
    Terminate_CroesusProcess();
    Runner.Stop(true); 
  }
}

function AddFilter(name,cmbField,filterValue,cmbFieldOperator){
  Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
  
  SetAutoTimeOut();
  if(!Get_SubMenus().Exists){
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
  }
  RestoreAutoTimeOut();
  
  Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
  Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click();
  Get_WinCRUFilter_GrpDefinition_TxtName().Keys(name);
  Get_WinCRUFilter_GrpCondition_CmbField().set_Text(cmbField);
  Get_WinCRUFilter_GrpCondition_CmbOperator().set_Text(cmbFieldOperator);  
  SetAutoTimeOut();
  if(!Get_WinCRUFilter_GrpCondition_TxtValueDouble().VisibleOnScreen){
    Get_WinCRUFilter_GrpCondition_TxtValue().Keys(filterValue);
  }else{
    Get_WinCRUFilter_GrpCondition_TxtValueDouble().set_Text(filterValue);
  }
  RestoreAutoTimeOut();
  Get_WinCRUFilter_BtnOK().Click();
  Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().WaitProperty("IsEnabled", true, 5000);
  Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
  WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071",15000);
}

function ApplyFilter(name){
   Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
  
  SetAutoTimeOut();
  if(!Get_SubMenus().Exists){
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
  }
  RestoreAutoTimeOut();
  
  Get_SubMenus().FindChild("WPFControlText",name,10).Click();
  
}

function Step2Step3Spet4(module){
  //******************************************* Étape 2***************************************************        
      Log.Message("Étape 2: Ajouter des filtres dans le module"+ module);
      
      Log.Message("Créer et applique 4 filtres");
      for (i=0; i<4; i++){
          var nameFilter= GetData(filePath_Clients, "CR1352", 401+i, language);
          var cmbField = GetData(filePath_Clients, "CR1352", 405+i, language);
          var CmbOperator= GetData(filePath_Clients, "CR1352", 409+i, language);
          var filterValue= GetData(filePath_Clients, "CR1352", 413+i, language);
          AddFilter(nameFilter,cmbField,filterValue,CmbOperator)
      };
      
      Log.Message("Les filtres A, B, C et D sont sauvegardés dans cet ordre")
      for (i=0; i<4; i++){
         var nameFilter= GetData(filePath_Clients, "CR1352", 401+i, language);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(i+1), "IsVisible", cmpEqual, true)
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(i+1).DataContext, "FilterDescription", cmpEqual, nameFilter)
      };
      
      //******************************************* Étape 3***************************************************        
      Log.Message("Raffraichir la grille "+ module +"pour désactiver les filtres");
      
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
           
      //******************************************* Étape 4***************************************************        
      Log.Message("Appliquer les filtres B, C, A et D dans cet ordre puis fermer l'application ");
      
      Log.Message("Appliquer les filtres")
      var arr = ["B","C","A","D"]
      for (i=0; i<4; i++){
        ApplyFilter(arr[i]);
      };
   
      Log.Message("Valider que les filtres sont appliqués")
      for (i=0; i<4; i++){
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(i+1), "IsVisible", cmpEqual, true)
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(i+1).DataContext, "FilterDescription", cmpEqual, arr[i])
      };
      
}

function Step5(moduleTxt, moduleFunction){
      //******************************************* Étape 5***************************************************        
      Log.Message("Jira: CRM-3658. Réouvrir l'application puis aller dans le module "+moduleTxt);

      moduleFunction.Click();
      moduleFunction.WaitProperty("IsChecked", true, 1000);
      Get_MainWindow().Restore();
           
      var arr = ["B","C","A","D"]
      Log.Message("Les filtres sont appliquer et affichés dans l'ordre de leurs création: A, B, C et D car il y une anomalie Jira: CRM-3658");
      Log.Message("Valider que les filtres sont appliqués dans le bon ordre B, C, A,D")
      SetAutoTimeOut();
      for (i=0; i<4; i++){
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(i+1), "IsVisible", cmpEqual, true)
         //aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(i+1).DataContext, "FilterDescription", cmpEqual, arr[i])   //Cette condtion a été mis en commentaire suite à la story TCVE-5668
      };
      RestoreAutoTimeOut();
      Log.Message("Jira: CRM-3658")
      
}