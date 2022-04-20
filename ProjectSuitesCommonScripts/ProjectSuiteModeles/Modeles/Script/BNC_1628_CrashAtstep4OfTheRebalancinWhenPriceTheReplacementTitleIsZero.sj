//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
        Description : 
                  User = Keynej 
                  1- Créé modele comme suite : 
                  Titre principal = XBB - % Cible= 2 - Titre de rechange = 760943 (prix au marché=0) 
                  Portefeuille assigné = 800067-RE. 
                  2- Rééquilibrer jusqu'a étape 4 

                  Résultat obtenu : Message : 'une erreur est survenu dutrant le rééquilibrage du portefeuille'.

    Auteur : Sana Ayaz
    Anomalie:BNC-1628
    Version de scriptage:ref90-04-BNC-59B-11
*/
function BNC_1628_CrashAtstep4OfTheRebalancinWhenPriceTheReplacementTitleIsZero()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles)
        //Se connecter avec KEYNEJ
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
       
       var modelNameBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelNameBNC_1628", language+client);
       var TypModelBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TypModelBNC_1628", language+client);
       var IACodeBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "IACodeBNC_1628", language+client);
       var securityXBB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "securityXBB", language+client);
       var ValuCibleBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ValuCibleBNC_1628", language+client);
       var TypSymbolBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TypSymbolBNC_1628", language+client);
       var TypTitreBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TypTitreBNC_1628", language+client);
       var NumberTSecurityBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NumberTSecurityBNC_1628", language+client);
       var DescriptSecurityBNC_1628 =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "DescriptSecurityBNC_1628", language+client);
       var NumbAccount800067RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NumbAccount800067RE", language+client);
       var NumberTheBugBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NumberTheBugBNC_1628", language+client);
       
        /*       1- Créé modele comme suite : 
                  Titre principal = XBB - % Cible= 2 - Titre de rechange = 760943 (prix au marché=0) 
                  Portefeuille assigné = 800067-RE. */
                    
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        // 4. Créer un nouveau modèle.
         Get_ModulesBar_BtnModels().Click();
         Create_Model(modelNameBNC_1628, TypModelBNC_1628, IACodeBNC_1628)
         SearchModelByName(modelNameBNC_1628);
         Get_ModelsGrid().Find("Value",modelNameBNC_1628,10).Click();
       
         //Mailler vers le module portefeuille
          Get_MenuBar_Modules().Click();
          Get_MenuBar_Modules_Portfolio().Click();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        
          Get_Toolbar_BtnAdd().Click();      
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73)   
          
          Get_WinAddPositionSubmodel_GrpAdd_CmbSecurityPicker().Click();
          Get_SubMenus().Find("Text",TypSymbolBNC_1628,10).Click();
          Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(securityXBB);
          Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
          Get_WinAddPositionSubmodel_TxtValuePercent().Keys(ValuCibleBNC_1628);   
                          
           Get_WinAddPositionSubmodel_GrpSubstitutionSecurities_BtnEdit().Click(); 
           Get_WinSubstitutionSecurities_BtnAdd().Click();
         Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation                  
          Get_WinReplacement_GrpSubstitutionSecurity_CmbSecurityPicker().Click();
         Get_SubMenus().Find("Text",TypTitreBNC_1628,10).Click();
         Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(NumberTSecurityBNC_1628);
         Get_WinReplacement_GrpSubstitutionSecurity_BtnSearch().Click();
         Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity().Click();
         Get_WinReplacement_BtnOK().Click();
         Get_WinSubstitutionSecurities_DgvSubstitutions().FindChild("Value", DescriptSecurityBNC_1628, 10).Click();
         Get_WinSubstitutionSecurities_BtnOK().Click();
         Get_WinAddPositionSubmodel_BtnOK().Click();
         
                 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        //  Portefeuille assigné = 800067-RE. 
          Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();      
        Get_ModelsGrid().Find("Value",modelNameBNC_1628,10).Click();
        Get_Models_Details_TabAssignedPortfolios().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
      
        
        Get_WinPickerWindow_DgvElements().Keys(NumbAccount800067RE.charAt(0));
        Get_WinQuickSearch_TxtSearch().keys(NumbAccount800067RE.slice(1));
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
          /* 2- Rééquilibrer jusqu'a étape 4 */
        Get_Toolbar_BtnRebalance().Click()
        Get_WinRebalance().Parent.Maximize();
        
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click(); 
        
        
      
       //  Résultat obtenu : Message : 'une erreur est survenu dutrant le rééquilibrage du portefeuille'.
        CheckPointForCrash(NumberTheBugBNC_1628);
       
        
        Get_WinRebalance_BtnClose().Click() 
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
   

     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        SearchModelByName(modelNameBNC_1628);
        Get_ModelsGrid().Find("Value",modelNameBNC_1628,10).Click();
        
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbAccount800067RE,10).Exists){
           Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbAccount800067RE,10).Click();
           Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
           /*var width = Get_DlgCroesus().Get_Width();
           Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
           var width = Get_DlgConfirmation().Get_Width();
           Get_DlgConfirmation().Click((width*(1/3)),73);
         }
         if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbAccount800067RE,10).Exists){
           Log.Error("Le compte est toujours associé au modèle")
         }
         else{
           Log.Checkpoint("Le compte n'est plus associé au modèle")}
        
        SearchModelByName(modelNameBNC_1628);
        Get_ModelsGrid().Find("Value",modelNameBNC_1628,10).Click();
        DeleteModelByName(modelNameBNC_1628);
        Terminate_CroesusProcess(); //Fermer Croesus
}
}
function CheckPointForCrash(NumberTheBug)
{
  maxWaitTime = 10000;
        waitTime = 0;
        errorDialogBoxDisplayed = Get_DlgError().Exists;
        while (!errorDialogBoxDisplayed && waitTime < maxWaitTime){
            Delay(1000);
            waitTime += 1000;
            errorDialogBoxDisplayed = Get_DlgError().Exists;
        }
        
        Log.Message("Waited for the Error dialog box during " + waitTime + " ms.");
        
        if (errorDialogBoxDisplayed){
            Log.Error("Croesus crashed.")
            Log.Error(NumberTheBug);
            Get_DlgError_BtnOK().Click();
        }
        else
            Log.Checkpoint("No crash detected.")
}

function test123()
{
   var modelNameBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelNameBNC_1628", language+client);
       var TypModelBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TypModelBNC_1628", language+client);
       var IACodeBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "IACodeBNC_1628", language+client);
       var securityXBB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "securityXBB", language+client);
       var ValuCibleBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ValuCibleBNC_1628", language+client);
       var TypSymbolBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TypSymbolBNC_1628", language+client);
       var TypTitreBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TypTitreBNC_1628", language+client);
       var NumberTSecurityBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NumberTSecurityBNC_1628", language+client);
       var DescriptSecurityBNC_1628 =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "DescriptSecurityBNC_1628", language+client);
       var NumbAccount800067RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NumbAccount800067RE", language+client);
       var NumberTheBugBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NumberTheBugBNC_1628", language+client);
       
       Get_WinReplacement_GrpSubstitutionSecurity_CmbSecurityPicker().Click();
       Get_SubMenus().Find("Text",TypTitreBNC_1628,10).Click();
       Log.Message( TypTitreBNC_1628);

}