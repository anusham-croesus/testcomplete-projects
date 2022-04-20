//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/**
    Description : Valider le fonctionnement du bouton Performance.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4118
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version :ref90-10-Fm-6--V9

*/

function Regression_CROES_4118_Acc_ValidatePerformanceButtonOperation()
{
 try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4118","CROES_4118");

    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
    var accountNo= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo_Croes4118", language+client);
    
    //se connecter avec UNI00
    Login(vServerAccounts, userNameUNI00, passwordUNI00, language);
    
    //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click();
    
    //chercher le compte "800241-GT"
    SelectAccounts(accountNo);

    //Aller sur "Performance"
    Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();
    
    //Ecrire la requete sql suivante
    var RCI= Execute_SQLQuery_GetFieldAllValues("select * from b_statis where no_compte ='800241-GT' And DATE_MAJ = 'Nov 30 2009'",vServerAccounts, "MONTH_ROI" )
    if(language == "french"){
    RCI= aqString.Replace(RCI, ".", ",")
    }
      else{
    Log.Message(RCI);
    }
    //Comparer les données sur performance et le resultat de la requete
    var RciNEt=Get_WinPerformance().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter",2], 10).FindChild("Uid","MonthlyRoi", 10).WPFObject("XamNumericEditor", "", 1).DisplayText;
   Log.Message(RciNEt)
  if (VarToString(RCI)== RciNEt)
    {
        Log.Checkpoint("The RCI net% are equals between Croesus and the query")
    }
    else{
        Log.Error("The values are different")
    }
 }
 catch(e) 
    {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    } 
    
 finally {

       Terminate_CroesusProcess();
    
    }
}
