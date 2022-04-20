//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA







function CreateCriterion(CriterionName, numeroTel){
    
    Log.Message("Add the '" + CriterionName + "' search criterion.");
    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
    WaitObject(Get_CroesusApp(),"Uid","LocaleTextbox_a093");
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(CriterionName);
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_telephoneNumber().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_EndingWith().Click();
    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().DblClick();
    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Keys(numeroTel)
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
}

function CreateCriterion_EmailAddress(CriterionName, adressecouriel){
    
    Log.Message("Add the '" + CriterionName + "' search criterion.");
    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
    WaitObject(Get_CroesusApp(),"Uid","LocaleTextbox_a093");
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(CriterionName);
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_emailAddress1().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_Containing().Click();
    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Click();
    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Keys(adressecouriel)
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
}

function CreateCriterion_VilleProvince(CriterionName, villeProvince){
    
    Log.Message("Add the '" + CriterionName + "' search criterion.");
//    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
//    WaitObject(Get_CroesusApp(),"Uid","LocaleTextbox_a093");
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(CriterionName);
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_CityOrProvince().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_startingWith().Click();
    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Click();
    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Keys(villeProvince)
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
}

function CreateAdvancedCriterion(AdvancedCriterionName,module,informativeHeader,BasicFieldsHeader,codePostalHeader, codepostale){
    
            Log.Message("Add the '" + AdvancedCriterionName + "' search criterion.");
            Get_Toolbar_BtnManageSearchCriteria().Click();
            WaitObject(Get_CroesusApp(),"Uid","ManagerWindow_efa9") 
            Get_WinSearchCriteriaManager_BtnAddAdvanced().Click();
            WaitObject(Get_CroesusApp(),"Uid","BaseDialog_136b");
            Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().Clear();
            Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().Keys(AdvancedCriterionName);
            Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField().Click();
            Get_SubMenus().Find("WPFControlText",module,10).OpenMenu();
            Get_CroesusApp().Find("Header",informativeHeader,20).Click();
            Get_CroesusApp().Find("Header",BasicFieldsHeader,20).Click();
            Get_CroesusApp().Find("Header",codePostalHeader,20).Click();
            Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_TxtValue().Keys(codepostale);
            Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnAddACondition().Click();
            Get_WinCRUSearchCriterionAdvanced_BtnSaveAndRefresh().Click();

    
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_EndingWith()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "se terminant par"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "ending with"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_Containing()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "contenant"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "containing"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_startingWith()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "débutant par"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "starting with"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_telephoneNumber()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "numéro de téléphone"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "telephone number"], 10)}
}
function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_emailAddress1()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "adresse de courriel 1"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "email address 1"], 10)}
}
function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_emailAddress2()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "adresse de courriel 2"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "email address 2"], 10)}
}
function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_emailAddress3()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "adresse de courriel 3"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "email address 3"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_CityOrProvince()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "ville ou province"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "city or province"], 10)}
}
function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_NAS()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "NAS"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "SIN"], 10)}
}
function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_StreetAddress()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "adresse civique"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "street address"], 10)}
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_PostalCode()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "code postal"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "postal code"], 10)}
}

function Get_DlgAddBoard_TvwSelectABoard_Ville_Province()
{
  if (language=="french"){return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Ville_province"], 10)}
  else {return Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", "Ville_province"], 10)}
}



function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_TxtValue(){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField","2"], 10)}

function Get_DashboardBar_gridCriteria(){return Get_DashboardBar().Find("Uid", "ScrollViewer_0078", 10)} 
function Get_RelationshipsGrid_ChEmail1()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: Email1"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: Email1"], 10)}
}

function Get_WinDetailedInfo_WinClientRoot(){
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniDialog", "Clients racines"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniDialog", "Root clients"], 10)}
}

function Get_WinDetailedInfo_WinClientRoot_btnOk(){return Get_WinDetailedInfo_WinClientRoot().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}
 

function Get_criteria_testtelephone(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "test_telephone1"], 10)}
  
