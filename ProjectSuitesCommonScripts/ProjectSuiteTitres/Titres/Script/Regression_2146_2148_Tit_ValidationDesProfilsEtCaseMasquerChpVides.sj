//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA 

/**
    
    Description :   - Vérifier le fonctionnement de la gestion des profils Titres
                    - Vérifier le fonctionnement de la gestion des profils Titres et de la case Masquer champs vides
                    
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2146
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2148
    Analyste d'automatisation : Amine Alaoui
    Complété par: Abdel Matmat 
    
*/

function Regression_2146_2148_Tit_ValidationDesProfilsEtCaseMasquerChpVides(){
 
    try{            
        //lien pour TestLink
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2146");
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2148");
        
        var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");            
        var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw"); 
        
        var security = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "SecurityBCE", language+client);
        
        var sous_titre_1 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "sous_titre_1", language+client);
        var sous_titre_2 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "sous_titre_2", language+client);
        var Carole_SG_1 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "Carole_SG_1", language+client);
        var Carole_SG_2 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "Carole_SG_2", language+client);
        var Carole_SG_3 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "Carole_SG_3", language+client);
        var Carole_SG_4 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "Carole_SG_4", language+client);
        var Titre_SG_1 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "Titre_SG_1", language+client);
        var Karine_1 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "Karine_1", language+client);
        var titre1 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "titre1", language+client);
        var titre2 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "titre2", language+client);
        var titre3 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "titre3", language+client);
            
       // Log.Message("**********************Login********************");
        Login(vServerTitre, userNameKeynej, passwordKeynej, language);
                          
        Log.Message("*******  Validation de la gestion des profils Titres  Croes-2146*****");
        
        Get_ModulesBar_BtnSecurities().Click();        
        Search_SecurityBySymbol(security);
        Get_SecurityGrid().Find("Value",security,10).Click();
        
        //Acceder à info Titre 
        Get_SecuritiesBar_BtnInfo().Click();
        
        //Onglet Profile
        Get_WinInfoSecurity_TabProfiles().Click();
        Get_WinInfoSecurity_TabProfiles_BtnSetup().Click();
        
        //Cocher quelques profils et décocher d'autres
        CheckProfile(1,1,1);
        UnCheckProfile(1,1,2);
        UnCheckProfile(2,1,1);
        UnCheckProfile(2,1,2);
        UnCheckProfile(2,1,3);
        UnCheckProfile(2,1,4);
        UnCheckProfile(2,2,1);
        CheckProfile(3,1,1);
        
        //Sauvegarder la configuration
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        ExpandProfile(titre1,1);
        ExpandProfile(titre3,2);
        
        //Vérifier que seulement les 2 profils cochés qui sont affichés dans la grille de l'onglet Profils de la fenêtre Info
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",sous_titre_1],10),"Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",sous_titre_1],10),"VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Karine_1],10),"Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Karine_1],10),"VisibleOnScreen", cmpEqual, true);
        
        //Vérifier que les profils décochés avant ne sont pas affichés
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",sous_titre_2],10),"Exists", cmpEqual, false);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Carole_SG_1],10),"Exists", cmpEqual, false);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Carole_SG_2],10),"Exists", cmpEqual, false);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Carole_SG_3],10),"Exists", cmpEqual, false);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Carole_SG_4],10),"Exists", cmpEqual, false);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Titre_SG_1],10),"Exists", cmpEqual, false);
        
        //Cocher les profils qui vient avec le Dump
        Get_WinInfoSecurity_TabProfiles_BtnSetup().Click();
        CheckProfile(1,1,1);
        CheckProfile(1,1,2);
        CheckProfile(2,1,1);
        CheckProfile(2,1,2);
        CheckProfile(2,1,3);
        CheckProfile(2,1,4);
        CheckProfile(2,2,1);
        UnCheckProfile(3,1,1);
        //Sauvegarder la configuration
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        ExpandProfile(titre1,1);
        ExpandProfile(titre2,2);
       
       //Fermer la fenêtre Info
        Get_WinInfoSecurity_BtnOK().Click();
        
        //Se déconnecter et connecter avec UNI00
        Terminate_CroesusProcess();  
        Login(vServerTitre, userNameUNI00, passwordUNI00, language);
        
        //************* CROES-2148 ****************************************************************************************
        Log.Message("----------- CROES-2148 ---------------------------");
        Get_ModulesBar_BtnSecurities().Click();        
        Search_SecurityBySymbol(security);
        Get_SecurityGrid().Find("Value",security,10).Click();
        
        //Acceder à info Titre 
        Get_SecuritiesBar_BtnInfo().Click();
        
        //Onglet Profile
        Get_WinInfoSecurity_TabProfiles().Click();
        Get_WinInfoSecurity_TabProfiles_BtnSetup().Click();
        
        //Cocher quelques profils et décocher d'autres
        CheckProfile(1,1,1);
        UnCheckProfile(1,1,2);
        CheckProfile(2,1,1);
        CheckProfile(2,1,2);
        UnCheckProfile(2,1,3);
        UnCheckProfile(2,1,4);
        UnCheckProfile(2,2,1);
        UnCheckProfile(3,1,1);
        
        //Sauvegarder la configuration
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        ExpandProfile(titre1,1);
        ExpandProfile(titre2,2);
        
        //Valider que les trois profiles sélectionnés sont affichés
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",sous_titre_1],10),"Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",sous_titre_1],10),"VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Carole_SG_1],10),"Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Carole_SG_1],10),"VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Carole_SG_2],10),"Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Carole_SG_2],10),"VisibleOnScreen", cmpEqual, true);
        
        //Renseigner un profil
        var textField = Aliases.CroesusApp.winInfoSecurity.WPFObject("TabControl", "", 1).WPFObject("_currentControl").WPFObject("_itemsControl").WPFObject("Expander", "Carole Titre", 2).WPFObject("ItemsControl", "", 1).WPFObject("_secondLevelExpander").WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 2).WPFObject("DoubleValue");
        textField.Keys(12345);
        
        //Cocher l'option Masquer champs vide
        Get_WinInfoSecurity_TabProfiles_ChkHideEmptyProfiles().set_IsChecked(true);
        Get_WinInfoSecurity_TabProfiles_ChkHideEmptyProfiles().WaitProperty("IsChecked", true, 30000); 
        
        //Valider que seulemnt le champs renseigné est affichés, les champs vides ne sont pas affichés
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Carole_SG_2],10),"Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Carole_SG_2],10),"VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",sous_titre_1],10),"VisibleOnScreen", cmpEqual, false);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfileGrid().Find(["ClrClassName","Text"],["TextBlock",Carole_SG_1],10),"VisibleOnScreen", cmpEqual, false);
        
        
        }
    catch (e) {            
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
           }         
    finally {           
       //Dérenseigner le champ et décocher l'option Masquer champs vide
        textField.Clear();
        Get_WinInfoSecurity_TabProfiles_ChkHideEmptyProfiles().set_IsChecked(false);
        
       //Cocher les profils qui vient avec le Dump
       Get_WinInfoSecurity_TabProfiles_BtnSetup().Click();
       CheckProfile(1,1,1);
       CheckProfile(1,1,2);
       CheckProfile(2,1,1);
       CheckProfile(2,1,2);
       CheckProfile(2,1,3);
       CheckProfile(2,1,4);
       CheckProfile(2,2,1);
       UnCheckProfile(3,1,1);
       //Sauvegarder la configuration
       Get_WinVisibleProfilesConfiguration_BtnSave().Click();
       
       //Fermer la fenêtre Info
        Get_WinInfoSecurity_BtnOK().Click();
        
       // Close Croesus 
       Terminate_CroesusProcess();        
       }                    
}

function Get_CheckBoxProfile(index1,index2,index3){
  return Get_WinVisibleProfilesConfiguration().WPFObject("_profilGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index2).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index3).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1);
  
}

function CheckProfile(index1,index2,index3){
 //Get_CheckBoxProfile(index1,index2,index3).set_IsChecked(true);
 if (Get_CheckBoxProfile(index1,index2,index3).get_IsChecked()== false)
    Get_CheckBoxProfile(index1,index2,index3).Click(Get_CheckBoxProfile(1,1,1).get_ActualWidth()/2,Get_CheckBoxProfile(1,1,1).get_ActualHeight()/2);
}
function UnCheckProfile(index1,index2,index3){
 //Get_CheckBoxProfile(index1,index2,index3).set_IsChecked(false);
 if (Get_CheckBoxProfile(index1,index2,index3).get_IsChecked()== true)
    Get_CheckBoxProfile(index1,index2,index3).Click(Get_CheckBoxProfile(1,1,1).get_ActualWidth()/2,Get_CheckBoxProfile(1,1,1).get_ActualHeight()/2);
}

function Get_WinInfoSecurity_TabProfileGrid(){
  return Get_WinInfoSecurity().Find("Uid","ProfilWindowComponent_9049",10);
}

function ExpandProfile(titre,index){
    var expander = Get_WinInfoSecurity().WPFObject("TabControl", "", 1).WPFObject("_currentControl").WPFObject("_itemsControl").WPFObject("Expander", titre, index);
    if (expander.IsExpanded == false)
        expander.Click(10,10);
}
function test(){
   ExpandProfile("titre")
}