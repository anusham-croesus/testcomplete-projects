//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Transactions_Get_functions


/* Description : Aller au module "Transaction" en cliquant sur BarModules-btnTransactions. , 
Vérifier la présence des contrôles, des étiquetés dans la partie de détail. 
(Le script test les étiquettes et les contrôles pour la première ligne sélectionnée ) */ 


function Survol_Tra_MainWin_Details()
{
   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click();
   
     WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
     WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
     Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
       
  //Les points de vérification en français 
  Check_Properties(language)
     
  Close_Croesus_SysMenu();
}

function Check_Properties(language)
{
  //Transaction Info
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo(), "Header", cmpEqual,GetData(filePath_Transactions,"Details",2,language));
  
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtName(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtName(), "IsManipulationEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtAccountNo(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtAccountNo(), "IsManipulationEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtIACode(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtIACode(), "IsManipulationEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtSource(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtSource(), "IsManipulationEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtCF(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtCF(), "IsManipulationEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtDescription(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtDescription(), "IsManipulationEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtSymbol(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtSymbol(), "IsManipulationEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtNote(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpTransactionInfo_TxtNote(), "IsManipulationEnabled", cmpEqual, false);
  
  
  //Detail
  aqObject.CheckProperty(Get_Transactions_GrpDetail(), "Header", cmpEqual, GetData(filePath_Transactions,"Details",3,language));
  //les points de vérifications de la  Quantity
  aqObject.CheckProperty(Get_Transactions_GrpDetail_LblQuantity(), "Text", cmpEqual, GetData(filePath_Transactions,"Details",4,language));
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtQuantity(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtQuantity(), "IsManipulationEnabled", cmpEqual, false);
  //les points de vérifications de la Price
  aqObject.CheckProperty(Get_Transactions_GrpDetail_LblPrice(), "Text", cmpEqual, GetData(filePath_Transactions,"Details",5,language));
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtPrice(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtPrice(), "IsManipulationEnabled", cmpEqual, false);
  //les points de vérifications de la Total
  aqObject.CheckProperty(Get_Transactions_GrpDetail_LblTotal(), "Text", cmpEqual, GetData(filePath_Transactions,"Details",6,language));
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtTotal(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtTotal(), "IsManipulationEnabled", cmpEqual, false);
  //les points de vérifications de la Exchange Rate
  aqObject.CheckProperty(Get_Transactions_GrpDetail_LblExchangeRate(), "Text", cmpEqual, GetData(filePath_Transactions,"Details",7,language));
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtExchangeRate(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtExchangeRate(), "IsManipulationEnabled", cmpEqual, false);
  //les points de vérifications de la Accrued Int: 
  aqObject.CheckProperty(Get_Transactions_GrpDetail_LblAccruedInt(), "Text", cmpEqual, GetData(filePath_Transactions,"Details",8,language));
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtAccruedInt(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtAccruedInt(), "IsManipulationEnabled", cmpEqual, false);
  //les points de vérifications du Fees: 
  aqObject.CheckProperty(Get_Transactions_GrpDetail_LblFees(), "Text", cmpEqual, GetData(filePath_Transactions,"Details",9,language));
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtFees(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtFees(), "IsManipulationEnabled", cmpEqual, false);
   //Les points de vérifications du Commission
  aqObject.CheckProperty(Get_Transactions_GrpDetail_LblCommission(), "Text", cmpEqual,GetData(filePath_Transactions,"Details",10,language));
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtCommission(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtCommission(), "IsManipulationEnabled", cmpEqual, false);
  //Les points de vérifications de Transaction
  aqObject.CheckProperty(Get_Transactions_GrpDetail_LblTransaction(), "Text", cmpEqual, GetData(filePath_Transactions,"Details",11,language));
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtTransaction(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtTransaction(), "IsManipulationEnabled", cmpEqual, false);
  //Les points de vérifications de Processing
  aqObject.CheckProperty(Get_Transactions_GrpDetail_LblProcessing(), "Text", cmpEqual, GetData(filePath_Transactions,"Details",12,language));
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtProcessing(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtProcessing(), "IsManipulationEnabled", cmpEqual, false);
  //Les points de vérifications de Settlement:
  aqObject.CheckProperty(Get_Transactions_GrpDetail_LblSettlement(), "Text", cmpEqual, GetData(filePath_Transactions,"Details",13,language));
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtSettlement(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Transactions_GrpDetail_TxtSettlement(), "IsManipulationEnabled", cmpEqual, false);
}







