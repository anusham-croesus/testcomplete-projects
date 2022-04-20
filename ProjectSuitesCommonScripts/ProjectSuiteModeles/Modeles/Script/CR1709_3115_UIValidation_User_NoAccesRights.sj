//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1171
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x 

Analyste d'automatisation: Emna IHM
La version de scriptage: ref90-08-15 Dy
*/ 
 
 function CR1709_3115_UIValidation_User_NoAccesRights()
 {             
    try{  

        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'N' , ALLOW_ALTERNATIVE='N' WHERE  USER_NUM =143", vServerModeles)
        Execute_SQLQuery("update B_MODEL_TYPE set  ALLOW_REPLACEMENT = '', ALLOW_ALTERNATIVE=''", vServerModeles)
        RestartServices(vServerModeles);
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");       
        var modelChBonds=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChBonds", language+client);         
        var N49627 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionN49627", language+client);  
        var NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NBC100", language+client);
        var complement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Complement", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        
            
        Login(vServerModeles, user , psw ,language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        //Sélectionner le modèle CH BONDS  
        SearchModelByName(modelChBonds); 
        Get_ModelsGrid().Find("Value",modelChBonds,10).Click();
        // chainer vers le module Portefeuille
        Drag( Get_ModelsGrid().Find("Value",modelChBonds,10), Get_ModulesBar_BtnPortfolio());
        
        //Séléctionner la position N49627
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",N49627,10).Click();
        Get_PortfolioBar_BtnInfo().click();
        
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        //---Valider que la fenetre Info ne contient pas la colonne titre de rechange de remplacement  dans la section Titres de substitutions
        //---Cette validation n'est pas automatisée car elle n'est plus valable 
        //---D'après réponse Karima Mo.: Suite aux améliorations du CR1709, la colonne  titre de rechange de remplacement  dans la section 
        //---Titres de substitutions existe toujours même avec le script de l'étape 1 est à NO              
        
        //Ajouter NBC100
        Get_WinPositionInfo_BtnEdit().click();
        Get_WinSubstitutionSecurities_BtnAdd().click();
        AddSubstitutionSecuritiesTypeComplement(typePicker,NBC100);
        //Valider que NBC100 est ajouté comme complément 
        checkAddSubstitutionType(N49627,NBC100,complement);       
        
        //Sauvegarder
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();     
        
        /*allez dans modele ==> Séléctionner ch bonds ==> Section détails ==>Onglet positions 
        et valider que icone Tritre des complements - Un tooltip "Titres de complément"  "Complement securities" est affiché*/
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Get_ModelsGrid().Find("Value",modelChBonds,10).Click();        
        Get_Models_Details_TabPositions().Click();
        var index = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",N49627,10).DataContext.Index;
        Get_Models_Details_TabPositions_DgPosition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", index+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "2"], 10).HoverMouse(13,15)
        Log.Picture(Get_MainWindow(), "Icon + Tooltip Validation.", "Icon + Tooltip ScreenShot", pmHighest);
        //Icone - tooltip: Titre de complément Sur N49627 --> Validation d’icone ne peux pas être automatisée*/
        aqObject.CheckProperty( Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",N49627,10).DataContext.DataItem, "HasComplementSecurity", cmpEqual, true);
        aqObject.CheckProperty( Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",N49627,10).DataContext.DataItem, "HasReplacementSecurity", cmpEqual, false);
        aqObject.CheckProperty( Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",N49627,10).DataContext.DataItem, "HasAlternativeSecurity", cmpEqual, false); 
        aqObject.CheckProperty( Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",N49627,10).DataContext.DataItem, "HasReplacementAlternativeSecurity", cmpEqual, false);  
        
        Terminate_CroesusProcess(); //Fermer Croesus
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Log.Message("**************CleanUp*****************")
        //ResetData(modelChBonds,N49627,NBC100)
    }
    finally {  
        Login(vServerModeles, user , psw ,language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        ResetData(modelChBonds,N49627,NBC100)
        Terminate_CroesusProcess(); //Fermer Croesus
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = '' , ALLOW_ALTERNATIVE='' WHERE  USER_NUM =143", vServerModeles)
        Execute_SQLQuery("update B_MODEL_TYPE set  ALLOW_REPLACEMENT = 'Y', ALLOW_ALTERNATIVE='Y'", vServerModeles)
        RestartServices(vServerModeles);
    }
 }
 
 function AddSubstitutionSecuritiesTypeComplement(typePicker,symbole){
     
    Get_WinPickerWindow_DgvElements().Keys("N");
    Get_WinQuickSearch_TxtSearch().SetText(symbole);
    Get_WinQuickSearch_RdoSymbol().Set_IsChecked(true);      
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinPickerWindow_DgvElements().Find("Value",symbole,10).Click();
    Get_WinPickerWindow_BtnOK().Click();
 }
 
 function checkAddSubstitutionType(position,symbole,substituteType){
    aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",symbole,10).DataContext.DataItem,"SubstituteType",cmpEqual, substituteType)
    Get_WinSubstitutionSecurities_BtnOK().Click();  
    aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",symbole,10).DataContext.DataItem,"SubstituteType",cmpEqual, substituteType) 
    Get_WinPositionInfo_BtnOK().Click(); 
    
    var index = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DataContext.Index;
    Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", index+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "2"], 10).HoverMouse(13,15)
    Log.Picture(Get_MainWindow(), "Icon + Tooltip Validation.", "Icon + Tooltip ScreenShot", pmHighest);
    /*Valider que N49627 a juste un complément , aucune autres option n'est ajouté - 
    [valider l'icone des complement et Un tooltip "Titres de complément" est affiché (Pas encore automatisé)]
    Icone - tooltip: Titre de complément Sur N49627 --> Validation d’icone ne peux pas être automatisée*/
    aqObject.CheckProperty( Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DataContext.DataItem, "HasComplementSecurity", cmpEqual, true);
    aqObject.CheckProperty( Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DataContext.DataItem, "HasReplacementSecurity", cmpEqual, false);
    aqObject.CheckProperty( Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DataContext.DataItem, "HasAlternativeSecurity", cmpEqual, false); 
    aqObject.CheckProperty( Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DataContext.DataItem, "HasReplacementAlternativeSecurity", cmpEqual, false);  
 }
 
 function ResetData(model,position,symbole){
     
    SearchModelByName(model);
    Get_ModelsGrid().Find("Value",model,10).Click();
    // chainer vers le module Portefeuille
    Drag( Get_ModelsGrid().Find("Value",model,10), Get_ModulesBar_BtnPortfolio());
        
    //Séléctionner la position N49627
    Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position,10).Click();
    Get_PortfolioBar_BtnInfo().click();
        
    if(Get_DlgConfirmation().Exists){
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73) 
    }                    
    //Supprimer NBC100
    Get_WinPositionInfo_BtnEdit().click();
    if(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",symbole,10).Exists){
        Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",symbole,10).click();
        Get_WinSubstitutionSecurities_BtnRemove().click();
        if(Get_DlgConfirmation().Exists){
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73)}
    }
    Get_WinSubstitutionSecurities_BtnOK().Click(); 
    Get_WinPositionInfo_BtnOK().Click(); 
    //Sauvegarder
    Get_PortfolioBar_BtnSave().Click();
    Get_WinWhatIfSave_BtnOK().Click();     
 }
