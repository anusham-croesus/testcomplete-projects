//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT DBA
//USEUNIT GDO_2507_Generate_Criterion_In_OrdersModule_Case1

/* Le champ Côté a été ajouté dans GDO, le but est d'ajouter un filtre  sur ce nouveau champ  
https://jira.croesus.com/browse/TCVE-472
 
Analyste d'assurance qualité: Carole Turcotte
Analyste d'automatisation: Alhassane Diallo */ 
 
 function GDO_TCVE_472_Validate_Column_Cote_IsVisibleInFilters()
 {             
    try{  
      
    
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-472","Lien de la story dans Jira");
    
           //Declaration des Variables
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
       
           var filterAchat       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Filter1_TCVE472", language+client);
           var filterVente       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Filter2_TCVE472", language+client);
           var valueAchat        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ValueAchat_TCVE472", language+client);
           var valueVente        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ValueVente_TCVE472", language+client);
           var coteAchat         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CoteAchat_2507", language+client);
           var coteVente         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ValueVente_TCVE472", language+client);
           var operator         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "OperatorTCVE472", language+client);
//Étape1
     
           //Se connecter à croesus avec Keynej
           Log.Message("Se connecter à croesus avec Keynej")
           Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
           Get_MainWindow().Maximize();
       

           //Acceder au module Ordres
           Log.Message("Acceder au module Ordres");
           Get_ModulesBar_BtnOrders().Click();
          
//Étape2         
 
           //Ajouter un filtre:  Achat
           Log.Message("Ajouter un filtre Achat");
           AddFiter(filterAchat,operator,valueAchat);
           Log.Message("Crash lorsqu'on ajoute un filter. Jira :TCVE-2088");
           
           WaitObject(Get_CroesusApp(),"Uid","DataGrid_e262", maxWaitTime);  
           Get_OrderGrid().WaitProperty("IsEnabled",true,30000);
               
           //Validation: Tous les ordres dont côté égal(e) à Achat seront affichés
           Log.Message("Validation: Tous les ordres dont côté égal(e) à Achat seront affichés");
           var nbr = Get_OrderGrid().RecordListControl.Items.Count;
           for(var i = 0; i<nbr; i++) {
              aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "TypeForDisplay", cmpEqual,coteAchat);
           }   

//Étape3    
         
            //Desactiver le filtre Achat
            Log.Message("Desactiver le filtre Vente")      
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();   
          
          
          
//Etape4 
         
          //Ajouter un filtre Vente
          Log.Message("Ajouter un filtre Vente")
          AddFiter(filterVente,operator,valueVente)
          Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().WaitProperty("IsChecked",true,5000);
          
          WaitObject(Get_CroesusApp(),"Uid","DataGrid_e262", maxWaitTime);  
          Get_OrderGrid().WaitProperty("IsEnabled",true,30000);
                       
          //Validation: Tous les ordres dont côté égal(e) à Achat seront affichés
          Log.Message("Validation: Tous les ordres dont côté égal(e) à Vente seront affichés");
          var nbr = Get_OrderGrid().RecordListControl.Items.Count;
          for(var i = 0; i<nbr; i++) {
             aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "TypeForDisplay", cmpEqual,coteVente);
          }
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Delete_FilterCriterion(filterAchat,vServerOrders)//Supprimer le criterion de BD 
      Delete_FilterCriterion(filterVente,vServerOrders)//Supprimer le critère «criterionCoteAchat» cotecriterion de BD 
      Runner.Stop(true); 
    }
 }
 
 
 
//Fonction qui permets djaouter un filtre sur la colonne côté
function AddFiter(FilterName,Operator, TypeSide){

  //Ajouter un filtre...
  Log.Message("Ajouter un filtre...");
  Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click()
  Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click()
  Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
  Get_WinCRUFilter_TextName_ForOrdersAndSecurities().set_Text(FilterName);
  Get_WinCRUFilter_GrpCondition_CmbField_ForSecuritiesAndOrders().Click();
  Get_WinCRUFilter_CmbField_ItemSide_ForOrdersAndSecurities().Click();
  Get_WinCRUFilter_GrpCondition_CmbOperator_ForSecuritiesAndOrders().Click();
  //Get_WinCRUFilter_CmbOperator_ItemEquals_ForOrdersAndSecurities().Click(); 
  Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", Operator], 10).Click();
  Get_WinCRUFilter_GrpCondition_CmbValue_ForSecuritiesAndOrders().Click(); 
  Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", TypeSide], 10).Click();
  Get_WinCRUFilter_BtnOK_ForSecuritiesAndOrders().Click(); 
}











