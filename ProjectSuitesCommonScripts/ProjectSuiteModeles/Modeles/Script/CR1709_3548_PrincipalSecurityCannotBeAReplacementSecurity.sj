//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3548
    Analyste d'assurance qualité : Manel
    Analyste d'automatisation : Emna IHM
    Version : 90-06-Be-17
*/

function CR1709_3548_PrincipalSecurityCannotBeAReplacementSecurity()
{
    try {
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE USER_NUM =104", vServerModeles)
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                 
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3548", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
        var XCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityXCB", language+client);
        var targetXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetXCB_3548", language+client);
        var IVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityIVZ", language+client);
        var targetIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetIVZ_3548", language+client);
        var OBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OBA", language+client);
        var descriptionOBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDescriptionOBA", language+client);     
        var descriptionXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionXCB", language+client);
        var replacement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeReplacement", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client); 
        var account800058NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800058NA", language+client);
        var conflictMessageP1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "conflictMessage_3548_1", language+client);
        var conflictMessageP2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "conflictMessage_3548_2", language+client);
        var property=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PropertyForDlgWarningLblMessage", language+client);        
       
        //Login
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click(); 
                        
        Create_Model(modelName,modelType)
        //Recupérer Numéro du model crée        
        var modelNo = Get_ModelNo(modelName);
        
        //mailler vers portefeuille                     
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
         //Ajouter position XCB
        Get_Toolbar_BtnAdd().click();
        
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        //XCB à 15%
        AddPositionToModel(XCB,targetXCB,typePicker,"")
        
        //IVZ à 7% 
        Get_Toolbar_BtnAdd().Click();
        AddPosition(IVZ,targetIVZ,typePicker,"")
                                           
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(XCB); 
        CheckPresenceofPosition(IVZ); 
        
        //Ajouter Replacement OBA
        AddReplacementSecurity(typePicker,XCB,descriptionOBA,OBA,replacement)
        //Ajouter Replacement XCB
        AddReplacementSecurity(typePicker,IVZ,descriptionXCB,XCB,replacement)
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //assigné le compte 800058-NA au modèle
        Get_ModulesBar_BtnModels().Click();   
        AssociateAccountWithModel(modelName,account800058NA);
        
        //Rééquilibrer le modele - Module Modele
        Get_Toolbar_BtnRebalance().Click();        
        //Validation Message conflit - Le rééquilibrage est impossible
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), property, cmpEqual, conflictMessageP1+"\n\n"+modelName+", "+modelNo+"\n\n"+conflictMessageP2); //EM:Depuis CO-90-07-22-Be-1 Avant "Text" 
        Get_DlgWarning().Close();
        
        //mailler vers portefeuille                     
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
         
         //Valider le message de l'icone de conflit affiché sur la position IVZ 
         if(language=="english"){
          aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Find("Value",IVZ,10).DataContext.DataItem,"RemplacementSecurityConflictMessage",cmpContains,"Security ISHARES CDN DEX CP BD ETF ("+XCB+") is:\r\n    • used as a replacement security for the main security (INVESCO LTD ("+IVZ+")) in the model "+modelName+" ("+modelNo+")\r\n    • used as main security in the model "+modelName+" ("+modelNo+")\r\nThis creates a conflict.")
        }else{
          aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Find("Value",IVZ,10).DataContext.DataItem,"RemplacementSecurityConflictMessage",cmpContains,"Le titre ISHARES CDN DEX CP BD ETF ("+XCB+") est:\r\n    • utilisé comme titre de remplacement pour le titre principal (INVESCO LTD ("+IVZ+")) dans le modèle "+modelName+" ("+modelNo+")\r\n    • utilisé comme titre principal dans le modèle "+modelName+" ("+modelNo+")\r\nCette situation crée un conflit.")
        }        
        
        //Rééquilibrer le modele - Module Portefeuille
        Get_Toolbar_BtnRebalance().Click();        
        //Validation Message conflit - Le rééquilibrage est impossible
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), property, cmpEqual, conflictMessageP1+"\n\n"+modelName+", "+modelNo+"\n\n"+conflictMessageP2); //EM:Depuis CO-90-07-22-Be-1 datapool modifié Property="Message" Avant "Text"
        Get_DlgWarning().Close();
        
        
        //*************************************************Réinitialiser les données*********************************************************  
        /*Get_ModulesBar_BtnModels().Click(); 
        RestoreData(modelName,account800058NA);
        
        
        //Fermer Croesus
        Close_Croesus_X();*/
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
      
    }
    finally {
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)        
       
        //Réinitialiser les données
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();  
        RestoreData(modelName,account800058NA);
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Runner.Stop(true)
        //S'il y a lieu rétablir l'état ininial (Cleanup)
    }
}

function RestoreData(modelName,accountNo){
        
        SearchModelByName(modelName);        
        if(Get_ModelsGrid().Find("Value",modelName,10).Exists){
        
            //sélectionner le model
            Get_ModelsGrid().Find("Value",modelName,10).Click();
        
            //rechercher le compte assigné au modele (Onglet Portefeuilles assignés), séléctionner le et le supprimer
            if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",accountNo,10).Exists){
              Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",accountNo,10).Click();
              Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
              /*var width = Get_DlgCroesus().Get_Width();
              Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
              var width = Get_DlgConfirmation().Get_Width();
              Get_DlgConfirmation().Click((width*(1/3)),73);
            }else
              Log.Error("Le compte No " + accountNo + " n'est pas assigné au modele " + modelName)  
            
            aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0); 
        
            //Supprimer le modele
            Get_ModelsGrid().Find("Value",modelName,10).Click();
            Get_Toolbar_BtnDelete().click();
             /* if(Get_DlgCroesus().Exists){
                 var width = Get_DlgCroesus().Get_Width();
                 Get_DlgCroesus().Click((width*(1/3)),73)
             }*/ //EM : Modifié depuis CO: 90-07-22
            if(Get_DlgConfirmation().Exists){
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(1/3)),73);}
                
            //Vérifier la suppression de modele
           SearchModelByName(modelName);
           if(Get_ModelsGrid().Find("Value",modelName,10).Exists)
              Log.Error("Le modèle n’a pas été supprimé")         
           else
             Log.Checkpoint("Le modèle a été supprimé")
            
        }else
            Log.Error("Le modèle n'existe pas") 

}

function Test(){
var modelNo="~M-00017-0"
 var modelName="MODTEST"
var conflictMessageP1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "conflictMessage_3548_1", language+client);
        var conflictMessageP2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "conflictMessage_3548_2", language+client);
aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, conflictMessageP1+"\n\n"+modelName+", "+modelNo+"\n\n"+conflictMessageP2);
}