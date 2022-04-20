//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


//Fonctions communes pour le CR2436

function CheckMessageRestrictionRebalancing(restrictionText){
        var grid = Get_WinRebalance_TabProposedOrders().WPFObject("_openOrdersGrids").WPFObject("_openOrdersGrid").WPFObject("RecordListControl", "", 1);
        aqObject.CheckProperty(grid.Items ,"Count",cmpNotEqual,0);
        var grid1 = Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().Find(["ClrClassName","WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)
        var count = grid1.Items.Count;
        for (i=0; i<count; i++)
          aqObject.CheckProperty(grid1.Items.Item(i).DataItem ,"Description",cmpEqual,restrictionText);      
}

function CheckMessageEditedRestrictionRebalancing(restrictionText){
        var grid = Get_WinRebalance_TabProposedOrders().WPFObject("_openOrdersGrids").WPFObject("_openOrdersGrid").WPFObject("RecordListControl", "", 1);
        aqObject.CheckProperty(grid.Items ,"Count",cmpEqual,0);
        var grid1 = Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().Find(["ClrClassName","WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)
        var count = grid1.Items.Count;
        for (i=0; i<count; i++)
          aqObject.CheckProperty(grid1.Items.Item(i).DataItem ,"Description",cmpEqual,restrictionText);      
}


function AddNoteRestriction(restrictionText, severity){
        Get_WinCRURestriction_GrpNote_RdoNote().set_IsChecked(true);
        Get_WinCRURestriction_TxtRestriction().Keys(restrictionText);
        Get_WinCRURestriction_CmbSeverity().Click();
        Get_SubMenus().FindChild("Text",severity,10).Click();
        Get_WinCRURestriction_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "RestrictionWindow_1351")
}

function ValidateRestrictionInformation(grid, accessLevel,severity,restrictionText){
        var count = grid.Items.Count;
        for (i=0; i<count; i++){
            aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"AccessLevel",cmpEqual,accessLevel);
            aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Severity",cmpEqual, severity);
            aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Description",cmpEqual,restrictionText);           
        }    
}

function DeleteRestriction(item, accessLevel){
            Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",item,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRestrictions().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionManagerWindow_325f");
            Get_WinRestrictionsManager().Find("Text", accessLevel,10).Click();
            Get_WinRestrictionsManager_BarPadHeader_BtnDelete().Click();
            Get_DlgConfirmation_BtnDelete().Click();
            Get_WinRestrictionsManager_BtnClose().Click()    ;
}

function EditRestriction(item, accessLevel, severity){
            Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",item,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRestrictions().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionManagerWindow_325f");
            Get_WinRestrictionsManager().Find("Text", accessLevel,10).Click();
            Get_WinRestrictionsManager_BarPadHeader_BtnEdit().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionWindow_1351");
            Get_WinCRURestriction_CmbSeverity().Click();
            Get_SubMenus().FindChild("Text",severity,10).Click();
            Get_WinCRURestriction_BtnOK().Click();    
}

function AddPositionToModel_ToleranceAndMarketValue(security,percentage,marketValue,typePicker,securityDescription){

  Get_WinAddPositionSubmodel_GrpAdd_CmbSecurityPicker().Click();
  Get_SubMenus().Find("Text",typePicker,10).Click();
  Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(security);
  Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
  if(Get_SubMenus().Exists){
      if(Trim(VarToStr(securityDescription))!== "")
         Get_SubMenus().Find("Value",securityDescription,10).DblClick();
      else
         Get_SubMenus().Find("Value",security,10).DblClick();
  }
  Delay(1500)
  Get_WinAddPositionSubmodel_TxtValuePercent().Keys(percentage);
  Get_WinAddPositionSubmodel_TxtMarketValue().Keys(marketValue)
  
  Get_WinAddPositionSubmodel_BtnOK().Click();
  
}

function CheckMessagesRestrictionsRebalancing(item, RestrictionText, severity){
        var grid = Get_WinRebalance_TabProposedOrders().WPFObject("_openOrdersGrids").WPFObject("_openOrdersGrid").WPFObject("RecordListControl", "", 1);
        aqObject.CheckProperty(grid.Items ,"Count",cmpEqual,0);
        var grid1 = Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().Find(["ClrClassName","WPFControlOrdinalNo"], ["RecordListControl", "1"], 10);
        var count = grid1.Items.Count;
        for (i=0; i<count; i++){
             if (grid1.Items.Item(i).DataItem.ElementIdentifierForDisplay == item){
                 aqObject.CheckProperty(grid1.Items.Item(i).DataItem ,"Description",cmpEqual,RestrictionText);
                 aqObject.CheckProperty(grid1.Items.Item(i).DataItem ,"Severity",cmpEqual,severity);
             }
        }      
}

function DeleteAssignedRestrictions(restrictionName){
      Get_WinAssignedRestrictionsManager().Find("Text", restrictionName, 10).Click();
      Get_WinAssignedRestrictionsManager_BarPadHeader_BtnDelete().CliCk();
      Get_DlgConfirmation_BtnYes().Click();
  
}

function DeleteRestrictionsForConfiguration(restrictionName){
      Get_WinRestrictionsManagerForConfigurations().Find("Text", restrictionName, 10).Click();
      Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnDelete().Click();
      Get_DlgConfirmation_BtnYes().Click();
}

function DeleteCreteriaForConfiguration(creteriaName){
      Get_WinSearchCriteriaManager().Find("Text", creteriaName, 10).Click();
      Get_WinSearchCriteriaManager_BtnDelete().Click();
      Get_DlgConfirmation_BtnYes().Click();
}


function RebalancingModelToStepFour(modelName){
        SearchModelByName(modelName);
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        Log.Message("Rééquilibrer le modèle");
        Get_Toolbar_BtnRebalance().Click();
        Get_WinRebalance().Parent.Maximize();
            
        // Décocher toutes les cases à cocher.
        Log.Message("Décocher toutes les cases à cocher");
        Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
        Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
        Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
        //Continuer le Rééquilibrage et aller l'étape 4
        Log.Message("Continuer le Rééquilibrage et aller l'étape 4");
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();
        if(Get_WinWarningDeleteGeneratedOrders().Exists){
              Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
        }  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
}



function ReadFileLines(AFileName,restriction)
{
  var F, s;
   
  F = aqFile.OpenTextFile(AFileName, aqFile.faRead, aqFile.ctUTF8)//aqFile.ctANSI);
  F.Cursor = 0;
  Log.Message("File by lines:");
  while(! F.IsEndOfFile()){
    s = F.ReadLine();
    Log.Message(s);
    if (s == restriction)
       Log.Checkpoint("Le texte "+restriction+" existe dans le rapport généré");
  }
  F.Close();
}