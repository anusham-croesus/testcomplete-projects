//USEUNIT CR1483_Common_functions


/**
    Pour la repartition des risk rating : Créer les critères
*/
function CR1958_8_PreparationBD_RiskRatingAllocation()
{
    Log.Message("");
    Log.Message("************* CR1958_8_PreparationBD_RiskRatingAllocation() *************");
    
    //Aller au module Titres et ouvrir la fenêtre RiskRatingManager
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 100000);
    Get_SecuritiesBar_BtnRiskRatingManager().Click();
    
    //critère1 : CriterionCAD
    var criterionName1           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_SecurityCurrencyCAD_CriterionName", language + client);
    var criterionDescription1    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_SecurityCurrencyCAD_CriterionDescription", language + client);
    var isActiveStringValue1     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_SecurityCurrencyCAD_IsActive", language + client);
    var isOverwriteStringValue1  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_SecurityCurrencyCAD_IsOverwrite", language + client);
    var rating1                  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_SecurityCurrencyCAD_Rating", language + client);
    var securityCurrency1        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_SecurityCurrencyCAD_CurrencySymbol", language + client);
    var CreateRiskRatingConditionFunction1 = "CreateRiskRatingCondition_SecuritiesHavingSecurityCurrencyEqualTo(securityCurrency)";
    CreateRiskRatingConditionFunction1 = aqString.Replace(CreateRiskRatingConditionFunction1, "(securityCurrency)", '("' + securityCurrency1 + '")');
    
    //critère2 : CriterionUSD
    var criterionName2           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_SecurityCurrencyUSD_CriterionName", language + client);
    var criterionDescription2    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_SecurityCurrencyUSD_CriterionDescription", language + client);
    var isActiveStringValue2     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_SecurityCurrencyUSD_IsActive", language + client);
    var isOverwriteStringValue2  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_SecurityCurrencyUSD_IsOverwrite", language + client);
    var rating2                  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_SecurityCurrencyUSD_Rating", language + client);
    var securityCurrency2        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_SecurityCurrencyUSD_CurrencySymbol", language + client);
    var CreateRiskRatingConditionFunction2 = "CreateRiskRatingCondition_SecuritiesHavingSecurityCurrencyEqualTo(securityCurrency)";
    CreateRiskRatingConditionFunction2 = aqString.Replace(CreateRiskRatingConditionFunction2, "(securityCurrency)", '("' + securityCurrency2 + '")');
    
    //critère3 : CriterionSubcategories
    var criterionName3           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_Subcategories_CriterionName", language + client);
    var criterionDescription3    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_Subcategories_CriterionDescription", language + client);
    var isActiveStringValue3     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_Subcategories_IsActive", language + client);
    var isOverwriteStringValue3  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_Subcategories_IsOverwrite", language + client);
    var rating3                  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_Subcategories_Rating", language + client);
    var subcategoriesNames3      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1958_PreparationBD_RiskRatingCriterion_Subcategories_SubcategoriesNames", language + client);
    subcategoriesNames3 = '["' + aqString.Replace(subcategoriesNames3, "|", '","') + '"]';
    var CreateRiskRatingConditionFunction3 = "CreateRiskRatingCondition_SecuritiesHavingSubcategoriesEqualTo(arrayOfSubcategoryNames)";
    CreateRiskRatingConditionFunction3 = aqString.Replace(CreateRiskRatingConditionFunction3, "(arrayOfSubcategoryNames)", "(" + subcategoriesNames3 + ")");
    
    //Supprimer les critères existants de mêmes noms
    Delete_FilterCriterion(criterionName1, vServerRQS);
    Delete_FilterCriterion(criterionName2, vServerRQS);
    Delete_FilterCriterion(criterionName3, vServerRQS);
    
    //Créer le critère1 : CriterionCAD
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
    if (!AddARiskRatingCriterion(criterionName1, criterionDescription1, isActiveStringValue1, isOverwriteStringValue1, rating1, CreateRiskRatingConditionFunction1))
        Log.Error("Échec de l'ajout du critère : " + criterionName1);
    
    //Créer le critère2 : CriterionUSD
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
    if (!AddARiskRatingCriterion(criterionName2, criterionDescription2, isActiveStringValue2, isOverwriteStringValue2, rating2, CreateRiskRatingConditionFunction2))
        Log.Error("Échec de l'ajout du critère : " + criterionName2);
    
    //Créer le critère3 : CriterionSubcategories
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
    if (!AddARiskRatingCriterion(criterionName3, criterionDescription3, isActiveStringValue3, isOverwriteStringValue3, rating3, CreateRiskRatingConditionFunction3))
        Log.Error("Échec de l'ajout du critère : " + criterionName3);
    
    //Cliquer sur le bouton Simulate All
    Log.Message("Click on 'Simulate All' button.");
    Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods().Click();
    
    //Envoyer en production
    SendToProduction();
    
    //Fermer la fenêtre Risk Rating Criteria Manager
    Get_WinRiskRatingCriteriaManager_BtnClose().Click();
    
    //Exécuter le plugin RiskRating
    ExecuteCfLoaderRiskRatingPlugin();
}
