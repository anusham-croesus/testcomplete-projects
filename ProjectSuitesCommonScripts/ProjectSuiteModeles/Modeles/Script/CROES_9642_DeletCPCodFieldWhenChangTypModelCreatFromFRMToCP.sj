//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                  Le champ Code de CP doit se vider lorsqu'on change le type de modèle de FRM à CP

                  User=Keynej

                  1-Ajouter un modèle type=Firme == > Le champ Code de CP = _FRM et est grisé (ne pas cliquer OK)

                  2-Modifier le type de modèle de FRM à modèle CP dans le menu déroulant

                  Résultat obtenu : Le champ Code de CP = _FRM mais n'est plus grisé, donc est éditable.

                  Résultat attendu : Lorsque le type est Modèle CP, le champ Code de CP devrait être vide et éditable.

    Auteur : Sana Ayaz
    Anomalie:CROES-9642
    Version de scriptage:ref90-04-BNC-59B-11
*/
function CROES_9642_DeletCPCodFieldWhenChangTypModelCreatFromFRMToCP()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //Se connecter avec KEYNEJ
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
        var modelType1CROES9642=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelType1CROES9642", language+client);
        var modelType2CROES9642=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelType2CROES9642", language+client);
        var modelTextCodeCPCROES9642=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelTextCodeCPCROES9642", language+client);
        
        Get_ModulesBar_BtnModels().Click();
        
        //1-Ajouter un modèle type=Firme == > Le champ Code de CP = _FRM et est grisé (ne pas cliquer OK) 
        Get_Toolbar_BtnAdd().Click();
        
        SelectComboBoxItem(Get_WinModelInfo_GrpModel_CmbType(), modelType1CROES9642);
        //Les points de vérifications :Le champ Code de CP = _FRM et est grisé
        
        aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbIACode(), "Enabled", cmpEqual, false);//grisé
        aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbIACode(), "IACodeValue", cmpEqual, modelTextCodeCPCROES9642);//Code de CP = _FRM
        
        //   2-Modifier le type de modèle de FRM à modèle CP dans le menu déroulant
        SelectComboBoxItem(Get_WinModelInfo_GrpModel_CmbType(), modelType2CROES9642);
        
        /*Les points de vérification :
        Résultat attendu : Lorsque le type est Modèle CP, le champ Code de CP devrait être vide et éditable.
        */
        aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbIACode(), "Enabled", cmpEqual, true);//le champ Code de CP devrait être éditable
        aqObject.CheckProperty(Get_WinModelInfo_GrpModel_CmbIACode(), "WPFControlText", cmpEqual, "");//le champ Code de CP devrait être vide
        
       
        Log.Message("Anomalie : CROES-9642")
        

         Terminate_CroesusProcess(); 
        
      
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
                           
    }
}

