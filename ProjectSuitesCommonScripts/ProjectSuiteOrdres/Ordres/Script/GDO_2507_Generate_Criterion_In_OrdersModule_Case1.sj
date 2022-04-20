//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :Génération de critère dans le module des ordres cas 1
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2507
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
function GDO_2507_Generate_Criterion_In_OrdersModule_Case1()
{             
  try {
    //Declaration des Variables
    var user               = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
    var criterion          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CriterionName_2507", language+client);
    var status             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusExecuted_2483", language+client);
    var coteAchat          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CoteAchat_2507", language+client);
    var criterionCoteAchat = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CriterionCoteAchat_2507", language+client);
       
    //Login
    Login(vServerOrders, user , psw ,language);
       
    //Étape1
    //Acceder au module Ordres
    Log.Message("Acceder au module Ordres");
    Get_ModulesBar_BtnOrders().Click();
       

    //Étape2
    //Conter les ordres dans la grille avant l’application du critère 
    var countBefore=Get_OrderGrid().RecordListControl.Items.Count;
       
    //Cliquer sur Ajouter ou afficher un critère actif
    Log.Message("Cliquer sur Ajouter ou afficher un critère actif");
    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();  
        
    //Creation de critère «Saisir par "Liste des ordres ayant statut égal(e) à Exécuté" puis sauvegarder et régénérer»
    Log.Message("Création de critère «Saisir par Liste des ordres ayant statut égal(e) à Exécuté puis sauvegarder et regénérer»");
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(criterion);
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemStatus().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemExecuted().Click()
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();  
    Delay(2000);
       
    //Etape3
    //Validation
    var countAfter=Get_OrderGrid().RecordListControl.Items.Count;
    aqObject.CompareProperty(countAfter,cmpNotEqual,countBefore);    
       
    //Seuls les ordres executés seront affichés
    Log.Message("Seuls les ordres executés seront affichés");
    for (var i=0; i<countAfter; i++) {
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "Status", cmpEqual,status);
    }
       
    //Étape4
    //Cliquer sur Réafficher tout et conserver les crochets
    Log.Message("Cliquer sur Réafficher tout et conserver les crochets");
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click(); 
       
       
    //Validation : Le critèrer est enlevé
    Log.Message("Validation : Le critèrer est enlevé");
    var countAfter2 = Get_OrderGrid().RecordListControl.Items.Count;
    aqObject.CompareProperty(countAfter2,cmpNotEqual,countAfter);    
       
    for (var i=0; i<countAfter2; i++) {
        if (Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Status!=status) {
            Log.Message("Le critère est enlevé");
            break;
        }
    }
    
    //Etape5
    //Ajouter un nouveau critère
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Log.Message("Cliquer sur Ajouter ou afficher un critère actif");
    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click(); 
        
    //Saisir: Liste des ordres ayant côté égal(e) à Achat
    Log.Message("Saisir: Liste des ordres ayant côté égal(e) à Achat");
       
    //Creation de critère «Saisir par "Liste des ordres ayant côté égal(e) à Achat (Buy) puis sauvegarder et régénérer»
    Log.Message("Creation de critère «Saisir par Liste des ordres ayant côté égal(e) à Achat (Buy) puis sauvegarder et régénérer»");
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(criterionCoteAchat);
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSide().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();      
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemBuy().Click()
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    Delay(2000);
    
    //Validation: Tous les ordres dont côté égal(e) à Achat seront affichés
    Log.Message("Validation: Tous les ordres dont côté égal(e) à Achat seront affichés");
    var countAfter=Get_OrderGrid().RecordListControl.Items.Count;
    for (var i=0; i<countAfter; i++) {
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "TypeForDisplay", cmpEqual,coteAchat);
    }
    Close_Croesus_MenuBar();
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {   
    Terminate_CroesusProcess(); //Fermer Croesus
    Delete_FilterCriterion(criterion,vServerOrders); //Supprimer le criterion de BD 
    Delete_FilterCriterion(criterionCoteAchat,vServerOrders); //Supprimer le critère «criterionCoteAchat» cotecriterion de BD 
    Runner.Stop(true); 
  }
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSide()
{
  if (language == "french") {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "côté"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "side"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemBuy()
{
  if (language == "french") {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Achat"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Buy"], 10)}
}
