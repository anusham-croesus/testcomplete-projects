//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions


/* Description : Aller au module "Transaction" en cliquant sur BarModules-btnSecurities. Affichage de la fenêtre 'Croesus - Nicolas Copernic (COPERN)' contenant les boutons Info, 
Données historiques, Total détenu, Taux de change. Fermêture de l’application avec AltF4 */

function Survol_Tit_AltF4()
{

   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click();
   
   if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000)){
      //Les points de vérification 
     Check_Properties(language)
   }
   else{
     Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
   }
   
   Close_Croesus_AltF4()
}

//Fonctions  (les points de vérification pour les scripts qui testent Close_Application)
function Check_Properties(language)
{
    aqObject.CheckProperty(Get_TransactionsBar_BtnInfo().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Close_Application",2,language));
    aqObject.CheckProperty(Get_TransactionsBar_BtnInfo(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_TransactionsBar_BtnInfo(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_TransactionsBar_BtnGainsLosses().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Close_Application",3,language));
    aqObject.CheckProperty(Get_TransactionsBar_BtnGainsLosses(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_TransactionsBar_BtnGainsLosses(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_TransactionsBar_BtnPosition().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Close_Application",4,language));
    aqObject.CheckProperty(Get_TransactionsBar_BtnPosition(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_TransactionsBar_BtnPosition(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_TransactionsBar_BtnFilter().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Close_Application",5,language));
    aqObject.CheckProperty(Get_TransactionsBar_BtnFilter(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_TransactionsBar_BtnFilter(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_TransactionsBar_BtnAll().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Close_Application",6,language));
    aqObject.CheckProperty(Get_TransactionsBar_BtnAll(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_TransactionsBar_BtnAll(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_TransactionsBar_BtnDisplay().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Close_Application",7,language));
    aqObject.CheckProperty(Get_TransactionsBar_BtnDisplay(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_TransactionsBar_BtnDisplay(), "IsEnabled", cmpEqual, true);
}

