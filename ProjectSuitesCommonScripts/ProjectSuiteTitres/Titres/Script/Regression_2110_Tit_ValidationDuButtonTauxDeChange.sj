//USEUNIT Titres_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA 

/**
    
    Description : Valider le fonctionnement du boutton 'Taux de change' dans le module Titres
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2110   
    Analyste d'automatisation : Amine Alaoui 
    
*/

function Regression_2110_Tit_ValidationDuButtonTauxDeChange(){
 
    try{            
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2110");
        
        var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");   
        var date15_07_2009 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "Date15_07_2009", language+client); 
        var nbCurrency = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "CurrencyNumber", language+client);        
            
        Log.Message("**********************Login********************");                 
        Login(vServerTitre, userNameKeynej, passwordKeynej, language);
                          
        Get_ModulesBar_BtnSecurities().Click();
        Get_SecuritiesBar_BtnExchangeRate().Click();

        WaitObject(Get_CroesusApp()/* WinExchangeRate()*/, "Uid", "ExchangeRateWindow_4017");
        
        Get_WinExchangeRate().ClickR();
		if(language == "french"){
		Get_SubMenus().WPFObject("ContextMenu", "", 1).WPFObject("MenuItem", "Exporter vers MS Excel...", 4).Click();
		}else{
        Get_SubMenus().WPFObject("ContextMenu", "", 1).WPFObject("MenuItem", "Export to _MS Excel...", 4).Click();
		}
        Delay(5000);
        
        process = Sys.WaitProcess("EXCEL");
        if (process.Exists) {
            Log.Checkpoint("Fichier excel cree avec success")
        } else
            Log.Error("The process does not exist.");

        Get_WinExchangeRate_BtnSetup().Click();
        
        var count = Get_WinCurrencySelection_ListView().Items.Count;
        for (var i = 0; i < count; i++){          
            Get_WinCurrencySelection_ListView().Items.Item(i).set_IsSelected(false);
            } 
        Get_WinCurrencySelection_BtnOK().Click();
        aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_RecordList().Items, "Count", cmpEqual, 0);

        Get_WinExchangeRate_BtnSetup().Click();        
        var count = Get_WinCurrencySelection_ListView().Items.Count;
        for (var i = 0; i < count; i++){          
            Get_WinCurrencySelection_ListView().Items.Item(i).set_IsSelected(true);
            } 
        Get_WinCurrencySelection_BtnOK().Click();        
        aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_RecordList().Items, "Count", cmpEqual, count);
        
        Get_WinExchangeRate_TabCrossRates().Click();        
        aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_RecordList().Items, "Count", cmpNotEqual, 0);
        Get_WinExchangeRate_TabHistory().Click();
        aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_RecordList().Items, "Count", cmpNotEqual, 0);
        
        Get_WinExchangeRate_TabEquivalenceTable().Click();
        Get_WinExchangeRate_TabEquivalenceTable_CmbCurrency().Click();
        Get_WinExchangeRate_TabEquivalenceTable_CmbCurrency_Cad().Click();
        Get_WinExchangeRate_TabEquivalenceTable_txtDate().Click();
        Sys.Keys("[End][BS][BS][BS][BS][BS][BS][BS][BS]");
        Sys.Keys(date15_07_2009 + "[Tab]");
        
        //var queryString = "select * from b_conv where date_conv = '"+ date15_07_2009 +"' and (cur_to = 'CAD' or cur_fr = 'CAD')";
        var queryString = "select * from b_conv where date_conv = '07/15/2009' and (cur_to = 'CAD' or cur_fr = 'CAD')";
        var tabValues = Execute_SQLQuery_GetFieldAllValues(queryString, vServerTitre, "RATE");
        
        
        var nbCurrency = Get_WinExchangeRate_TabEquivalenceTable_RecordList().items.Count;
        Log.Message(nbCurrency);
        var nbColumn = 3;
        var ii = 0;
        for (var i = 0; i < nbCurrency*2; i++){                    
            j = (i%(nbCurrency)+1);
            k = nbColumn - (i-(i%(nbCurrency)))/(nbCurrency);
       //     Log.Message("i= "+i+"  j= "+j+"  k= "+k)
            var taux = Get_WinExchangeRate_TabEquivalenceTable_RecordList().Find(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", j],10).Find(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", k],10).Value;
           //Log.Message(taux)
            if (taux != "n/a" && taux != "n/d") {
                taux = RemoveExtraZero(taux); 
                Log.Message("Valeur BD: " + tabValues[ii] + "  Valeur affichée: " + taux)
                CheckEquals(taux,tabValues[ii],"Taux");
                ii++;
            }
        }
        Get_WinExchangeRate_BtnClose().Click();
        }
    catch (e) {            
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
           }         
    finally {           
       // Close Croesus 
       Terminate_CroesusProcess();        
       }                    
}
function RemoveExtraZero(aString){
    
    aString = aqString.Replace(aString, ".", ","); //REMPLACER LE POINT PAR VIRGULE
    var i = aqString.GetLength(aString)-1;
    while (aqString.GetChar(aString, i)=="0"){
        aString = aqString.Remove(aString, i, 1)
        i--;
        };
    if(aqString.GetChar(aString, aqString.GetLength(aString)-1)==",")
        aString = aqString.Remove(aString, aqString.GetLength(aString)-1, 1);  
    //if (language == "french") return aString;
    //else 
    return aqString.Replace(aString, ",", ".");
}

function test(){
        process = Sys.WaitProcess("EXCEL");
        if (process.Exists) {
            Log.Checkpoint("Fichier excel cree avec success")
        } else
            Log.Error("The process does not exist.");
}



