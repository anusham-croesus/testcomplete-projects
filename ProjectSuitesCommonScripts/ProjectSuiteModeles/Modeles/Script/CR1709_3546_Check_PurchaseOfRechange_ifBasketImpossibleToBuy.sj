//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT CR1709_3201_Check_AlternativeSecurity_Basket

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3546

Analyste d'assurance qualité: Manel 
Analyste d'automatisation: Youlia Raisper
La version de scriptage: ref90-04-BNC-59B-11--V9-1_8-co6x  */


function CR1709_3546_Check_PurchaseOfRechange_ifBasketImpossibleToBuy()
{
    try{  
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)
        Execute_SQLQuery("update B_MODEL_TYPE set  ALLOW_REPLACEMENT = 'Y', ALLOW_ALTERNATIVE='Y'", vServerModeles)
                                  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var securityNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC100", language+client);
        var targetNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetNBC100_3546", language+client);      
        var modelPanierObligation=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelPanierObligatio", language+client);
        var targetPanierObligation=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetPanierObligatio_3546", language+client);
        var newModel=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3546", language+client); 
        var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
        var account800241GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800241GT", language+client); 
        var Basket844000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Basket844000", language+client);
        var quantityNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNBC100_3546", language+client); 
        var modelTargetPercentNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent_NBC100_3546", language+client);
        var Basket844000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Basket844000", language+client);
        var displayQuantityBasket=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity_Basket_3546", language+client);
        var modelTargetPercentBasket=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent_Basket_3546", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var panier=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PanierObligCorpor", language+client);
        var basket=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Panier_3546", language+client);
        var securityDescriptionBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDescriptionBMO", language+client);
        var buy=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Buy", language+client); 
        var SecurityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client);
        
        var quantityNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNBC100_3546", language+client); 
        var quantity844000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity_Basket_3546", language+client); 
        var quantity844000_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity2_Basket_3546", language+client); 
        var quantityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBMO_3546", language+client); 
        var quantityBMO_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity2BMO_3546", language+client);
        
        var modelTargetPercentNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent_NBC100_3546", language+client);
        var modelTargetPercent2NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent2_NBC100_3546", language+client); 
        var displayQuantity844000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity_Basket_3546", language+client); 
        var modelTargetPercent84400=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent_Basket_3546", language+client);
        var modelTargetPercent84400_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent2_Basket_3546", language+client);  
        var displayQuantityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBMO_3546", language+client); 
        var modelTargetPercentBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent_BMO_3546", language+client); 
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message_3456", language+client);
        var property=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PropertyForDlgWarningLblMessage", language+client);
                                
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize(); 
        
        Create_Model(newModel,"",codeCP)
      
        SearchModelByName(newModel);
        Get_ModelsGrid().Find("Value",newModel,10).Click();
        Drag(Get_ModelsGrid().Find("Value",newModel,10), Get_ModulesBar_BtnPortfolio()); 
        
        //Ajouter une position NBC100
        Get_Toolbar_BtnAdd().Click();
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        AddPosition(securityNBC100,targetNBC100,typePicker,"") 
       
        //Ajouter un sous-modele  
        Get_Toolbar_BtnAdd().Click();               
        Get_WinAddPositionSubmodel_TxtSubmodel().Click();
        Get_WinAddPositionSubmodel_TxtSubmodel().Keys(modelPanierObligation);
        Get_WinAddPositionSubmodel_TxtSubmodel().Keys("[Enter]")
        if(Get_SubMenus().Exists){
          Get_SubMenus().Find("Value",modelPanierObligation,10).DblClick();
        }        
        Get_WinAddPositionSubmodel_TxtValuePercent().Keys(targetPanierObligation);
        Get_WinAddPositionSubmodel_BtnOK().Click();
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
               
        CheckPresenceofPosition(securityNBC100); 
        CheckPresenceofPosition(panier);
           
        //Assoccié compte 800241-GT 
        Get_ModulesBar_BtnModels().Click();
        AssociateAccountWithModel(newModel,account800241GT);
        
        //Rééquilibrer le modele créé en 1 jusqu'a etape 4 Valider les ordres onglet portefeuille projeté
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        }                                                 
        Get_WinRebalance().Parent.Maximize();  
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click(); 
         if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }   
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
         
        Search(Basket844000);   
         
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("DisplayText",Basket844000,10).DataContext.DataItem.DisplayQuantityStr,0,4),cmpEqual,aqString.SubString(displayQuantityBasket, 0, 4),true,3)           
        //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("DisplayText",Basket844000,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, displayQuantityBasket); 
        //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("DisplayText",Basket844000,10).DataContext.DataItem, "ModelTargetPercent", cmpEqual, modelTargetPercentBasket);
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("DisplayText",Basket844000,10).DataContext.DataItem.ModelTargetPercent,0,4),cmpEqual,aqString.SubString(modelTargetPercentBasket, 0, 4),true,3)  
 
        Search(securityNBC100);               
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityNBC100); 
        //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem, "ModelTargetPercent", cmpEqual, modelTargetPercentNBC100);
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem.ModelTargetPercent,0,4),cmpEqual,aqString.SubString(modelTargetPercentNBC100, 0, 4),true,3)
        
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        /*Visualiser le modele créé  dans portefeuille ==> séléctionner position panier ==> Info ==> Ajouter BMO comme titre de rechange sur la position panier*/
        SearchModelByName(newModel);
        Get_ModelsGrid().Find("Value",newModel,10).Click();
        Drag(Get_ModelsGrid().Find("Value",newModel,10), Get_ModulesBar_BtnPortfolio()); 
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",basket,10).DblClick();
        
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(3/5)),73);
              
        Get_WinSubModelInfo_GrpSubstitutionSecurities_BtnEdit().Click();
        Get_WinSubstitutionSecurities_BtnAdd().Click();
        Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(securityDescriptionBMO);
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys("[Tab]");
        aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity(), "IsChecked", cmpEqual,true);
        
        Get_WinReplacement_BtnOK().Click();
        Get_WinSubstitutionSecurities_BtnOK().Click();
        Get_WinSubModelInfo_BtnOK().Click();
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        /*Rééquilibrer le modele*/
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(newModel);
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        }                                                 
        Get_WinRebalance().Parent.Maximize();  
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
        
        /*valider qu'un ordre achat est générer sur le titre de rechange BMO afin  d'attendre la cible 75% du panier.*/
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem , "OrderTypeDescription", cmpEqual, buy); 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem , "DisplayQuantityStr", cmpEqual, quantityNBC100); 
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",Basket844000,10).DataContext.DataItem , "OrderTypeDescription", cmpEqual, buy); 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",Basket844000,10).DataContext.DataItem , "DisplayQuantityStr", cmpEqual, quantity844000_2);  
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",SecurityBMO,10).DataContext.DataItem , "OrderTypeDescription", cmpEqual, buy); 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",SecurityBMO,10).DataContext.DataItem , "DisplayQuantityStr", cmpEqual, quantityBMO);  
        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        
        Search(securityNBC100);  
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem.DisplayQuantityStr,0,4),cmpEqual,aqString.SubString(quantityNBC100, 0, 4),true,3)              
        //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityNBC100); 
        //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem, "ModelTargetPercent", cmpEqual, modelTargetPercent2NBC100); 
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem.ModelTargetPercent,0,4),cmpEqual,aqString.SubString(modelTargetPercent2NBC100, 0, 4),true,3)      
        
        Search(Basket844000);
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("DisplayText",Basket844000,10).DataContext.DataItem.DisplayQuantityStr,0,4),cmpEqual,aqString.SubString(quantity844000_2, 0, 4),true,3)               
        //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("DisplayText",Basket844000,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantity844000_2); 
        //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("DisplayText",Basket844000,10).DataContext.DataItem, "ModelTargetPercent", cmpEqual, modelTargetPercent84400_2); 
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("DisplayText",Basket844000,10).DataContext.DataItem.ModelTargetPercent,0,4),cmpEqual,aqString.SubString(modelTargetPercent84400_2, 0, 4),true,3)      
        
        Search(SecurityBMO);  
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",SecurityBMO,10).DataContext.DataItem.DisplayQuantityStr,0,4),cmpEqual,aqString.SubString(quantityBMO_2, 0, 4),true,3)              
        //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",SecurityBMO,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantityBMO_2); 
        //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",SecurityBMO,10).DataContext.DataItem, "ModelTargetPercent", cmpEqual, modelTargetPercentBMO); 
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",SecurityBMO,10).DataContext.DataItem.ModelTargetPercent,0,4),cmpEqual,aqString.SubString(modelTargetPercentBMO, 0, 4),true,3)      
        
         Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Terminate_CroesusProcess(); //Fermer Croesus
        
        /*Se connecter avec UNI00 pour modifier les parametres du panier et valider le cas si on ne peut pas acheter le panier c le rechange qu'on achete
        Dans modele ==> panier obligatio symbole 844000 ==> info ==> panier ==> décocher Achat permis et vente permise*/
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize(); 
        
        SearchModelByName(modelPanierObligation);
        Get_ModelsGrid().Find("Value",modelPanierObligation,10).DblClick();
        Get_WinModelInfo_TabBasket().Click();
        Get_WinModelInfo_TabBasket_ChkAllowBuy().set_IsChecked(false);
        Get_WinModelInfo_TabBasket_ChkAllowSell().set_IsChecked(false);
        Get_WinModelInfo_BtnOK().Click();
        
        //Validation
        Get_ModelsBar_BtnInfo().Click();
        Get_WinModelInfo_TabBasket().Click();
        aqObject.CheckProperty(Get_WinModelInfo_TabBasket_ChkAllowBuy(), "IsChecked", cmpEqual, false); 
        aqObject.CheckProperty(Get_WinModelInfo_TabBasket_ChkAllowSell(), "IsChecked", cmpEqual, false); 
        Get_WinModelInfo_BtnOK().Click();
        Terminate_CroesusProcess(); //Fermer Croesus
        
        /*Avec le user GP1859 rééquilibrer le modele tel que défini a étape 3 du cas de test et valider que le rééquilibrage est bloqué , 
        un message erreur est affiché :"Le modele détient un panier dont achat n'est pas permis . Le rééquilibrage a échoué ".*/
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        SearchModelByName(newModel);
        Get_Toolbar_BtnRebalance().Click();
        
        //Validation
        //Le fichier Excel n’a pas marché dans ce cas 
        if(language=="french"){
          aqObject.CheckProperty(Get_DlgWarning_LblMessage(), property, cmpEqual, "Le modèle détient un panier dont l’achat n’est pas permis. \r\nLe rééquilibrage a échoué."); //EM: Depuis CO-90-07-22-Be-1 datapool modifié Property="Message" Avant "Text" 
        }
        else{
          aqObject.CheckProperty(Get_DlgWarning_LblMessage(), property, cmpEqual, "The model holds a basket that cannot be purchased.\r\nThe rebalancing process has failed."); //EM: Depuis CO-90-07-22-Be-1 datapool modifié Property="Message" Avant "Text"
        }
        Get_DlgWarning().Close();
        Terminate_CroesusProcess(); //Fermer Croesus

        //***************************RestoreData**********************************       
        //RestoreData(newModel,account800241GT,modelPanierObligation)
                  
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally { 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        RestoreData(newModel,account800241GT,modelPanierObligation)
        Terminate_CroesusProcess(); //Fermer Croesus 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Runner.Stop(true);      
    }
}

function RestoreData(newModel,account800241GT,modelPanierObligation){

      var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
      Login(vServerModeles, user, psw, language);         
      Get_ModulesBar_BtnModels().Click();
      Get_MainWindow().Maximize();
      //Remove account from the model
      SearchModelByName(newModel);
      Get_ModelsGrid().Find("Value",newModel,10).Click();
      Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account800241GT,10).Click();
      Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
      /*var width = Get_DlgCroesus().Get_Width();
      Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
      var width = Get_DlgConfirmation().Get_Width();
      Get_DlgConfirmation().Click((width*(1/3)),73);
        
      aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0); 
      //Supprimer le model
      DeleteModelByName(newModel); 
  
      SearchModelByName(modelPanierObligation);
      Get_ModelsGrid().Find("Value",modelPanierObligation,10).DblClick();
      Get_WinModelInfo_TabBasket().Click();
      Get_WinModelInfo_TabBasket_ChkAllowBuy().set_IsChecked(true);
      Get_WinModelInfo_TabBasket_ChkAllowSell().set_IsChecked(true);
      Get_WinModelInfo_BtnOK().Click(); 
      
      //Validation
      Get_ModelsBar_BtnInfo().Click();
      Get_WinModelInfo_TabBasket().Click();
      aqObject.CheckProperty(Get_WinModelInfo_TabBasket_ChkAllowBuy(), "IsChecked", cmpEqual, true); 
      aqObject.CheckProperty(Get_WinModelInfo_TabBasket_ChkAllowSell(), "IsChecked", cmpEqual, true); 
      Get_WinModelInfo_BtnOK().Click();
}