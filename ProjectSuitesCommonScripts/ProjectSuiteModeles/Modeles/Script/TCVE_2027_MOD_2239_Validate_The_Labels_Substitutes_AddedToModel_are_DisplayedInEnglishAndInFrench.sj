//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions


/**
    Description : (MOD-2239) Valider que les libellés des substituts ajoutés au modèle 
    (complement, replacement, fallback) sont affichés en anglais et en français
        
    https://jira.croesus.com/browse/TCVE-2027
    Analyste d'assurance qualité : Christine P
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.18.2020.8-7
*/

function TCVE_2027_MOD_2239_Validate_The_Labels_Substitutes_AddedToModel_are_DisplayedInEnglishAndInFrench()
{
    try {
            //Afficher le lien du cas de test
            Log.Link("https://jira.croesus.com/browse/TCVE-2027") 
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10;
            
            
            //Afficher le lien du cas de test
            Log.Link("https://jira.croesus.com/browse/TCVE-1790") 
                               
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10;       
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         
            
            var mod_2239          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MOD_2239", language+client);
            var modelType         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
            var typePicker        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
            
           
            var securityBMO       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityBMO", language+client);
            var securityNA        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityNA", language+client);
            var securityTD        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityTD", language+client);
            var securityLB        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityLB", language+client);
            var securityRY        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityRY", language+client);
            var targetRY          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetRY", language+client);
            var VM_RY             = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetRY", language+client);
            var SearchBySymbol    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SEARCH_SYMBOL", language+client);
            
            var SubstituteTypeComplement    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SubstituteTypeComplement", language+client);
            var SubstituteTypeReplacement   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SubstituteTypeReplacement", language+client);
            var SubstituteTypeFalback       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SubstituteTypeFalback", language+client);
            
           
//Étape1    
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec Keynej");      
  
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
//Étape2         
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Créer le modèle de firme MOD_2239.");      
            
            
  
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           
          
            //Créer le modèle mod_M1423 
            Log.Message("Créer le modèle mod_M1423 "); 
            Create_Model(mod_2239,modelType)
            
//Étape3           
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3:Mailler le nouveau modèle vers le module Portefeuille et ajouter les positions / substituts suivants:"); 
                 
             //Ajouter "Ajouter la Position principale =  RY : Cible = 50 %, VM % = 50,
            Log.Message("Ajouter la Position principale =  RY : Cible = 50 %, VM % = 50, "); 
            SearchModelByName(mod_2239);
            Drag( Get_ModelsGrid().Find("Value",mod_2239,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
//            var width = Get_DlgConfirmation().Get_Width();
//            Get_DlgConfirmation().Click((width*(2/2.8)),73)
            Get_DlgConfirmation_btnNo().Click();
            
            //Ajouter de la  position RY
            Log.Message("Ajout de la  position RY")
            AddPositionToModel(securityRY,targetRY,typePicker,"") 
            
            //Sauvegarder le Modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
       
            Log.Message("Ajouter la position BMO comme titre de  complement  "); 
            Get_Portfolio_PositionsGrid().Find("Value",securityRY,10).Click();
            Get_PortfolioBar_BtnInfo().Click();
            Get_WinPositionInfo_GrpSubstitutionSecurities_BtnEdit().Click();
            Get_WinSubstitutionSecurities_BtnAdd().Click();
            Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
            
            Get_WinReplacement_GrpSubstitutionSecurity_CmbSecurityPicker().Click();
            Get_SubMenus().Find("Text",SearchBySymbol,10).Click();
            Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(securityBMO);
            Get_WinReplacement_GrpSubstitutionSecurity_BtnSearch().Click()
            Get_SubMenus().Find("Text",securityBMO,10).DblClick();
            Get_WinReplacement_BtnOK().Click();
            
            
            //Ajout du titre de remplacement et dtitre de rechange du remplacement 
            Log.Message("Ajout du titre de remplacement et du rechange de remplacement  "); 
            Get_WinSubstitutionSecurities_BtnAdd().Click();
            Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
            Get_WinReplacement_GrpSubstitutionSecurity_CmbSecurityPicker().Click();
            Get_SubMenus().Find("Text",SearchBySymbol,10).Click();
            Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(securityNA);
            Get_WinReplacement_GrpSubstitutionSecurity_BtnSearch().Click()
            Get_SubMenus().Find("Text",securityNA,10).DblClick();
            Get_WinReplacement_GrpSubstitutionType_RdoReplacementSecurity().set_IsChecked(true);
            Get_WinReplacement_GrpSubstitutionType_CmbSecurityPicker().Click();
            Get_SubMenus().Find("Text",SearchBySymbol,10).Click();
            Get_WinReplacement_GrpSubstitutionType_TxtSubstitutionType().Keys(securityLB); 
            Get_WinReplacement_GrpSubstitutionType_BtnSearch().Click();
            Get_SubMenus().Find("Text",securityLB,10).DblClick(); 
            Get_WinReplacement_BtnOK().Click();
            
            //Ajout du titre de rechange 
            Log.Message("Ajout du titre de rechange  "); 
            Get_WinSubstitutionSecurities_BtnAdd().Click();
            Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
            Get_WinReplacement_GrpSubstitutionSecurity_CmbSecurityPicker().Click();
            Get_SubMenus().Find("Text",SearchBySymbol,10).Click();
            Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(securityTD);
            Get_WinReplacement_GrpSubstitutionSecurity_BtnSearch().Click();
            Get_SubMenus().Find("Text",securityTD,10).DblClick();
            Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity().set_IsChecked(true);
            Get_WinReplacement_BtnOK().Click();
            Get_WinSubstitutionSecurities_BtnOK().Click();
            Get_WinPositionInfo_BtnOK().Click();
            
            
            //Sauvegarder le modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().Click();
            
            
//Étape4                    
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4: Ouvrir la fenêtre Info position et Vérifier que les libellés des substituts  (Complement, Replacement, Fallback) sont affichés en anglais dans la colonne Substitution type, à droite de l'icône. "); 
             
            Get_Portfolio_PositionsGrid().Find("Value",securityRY,10).Click();
            Get_PortfolioBar_BtnInfo().Click();

            
            // Vérifier que les libellés des substituts  (Complement, Replacement, Fallback) sont affichés dans la colonne "Substitution type".
            Log.Message("Vérifier que les libellés des substituts  (Complement, Replacement, Fallback) sont affichés dans la colonne Substitution type")
            aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_SubtitutionTypeComplement(),"Text", cmpEqual, SubstituteTypeComplement);
            aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_SubtitutionTypeReplacement(),"Text", cmpEqual, SubstituteTypeReplacement);
            aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_SubtitutionTypeFallback(),"Text", cmpEqual, SubstituteTypeFalback);
            
            
            Get_WinPositionInfo().Close();
/************************************************************************A noter*********************************************************************************/
//A noter que il n'est pas necessaire de faire les etapes 5,6 et 7 qui consiste en refaire les etapes mais cette fois ci en se connectant en francais en effet en  roulant le script dans les deux langues ces etapes sontcouverts          
 Log.Message("******************A noter que il n'est pas necessaire de faire les etapes 5,6 et 7 qui consiste en refaire les etapes mais cette fois ci en se connectant en francais en effet en  roulant le script dans les deux langues ces etapes sontcouverts************************" )         
            
            
            
            

 }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
        
    
           Log.PopLogFolder();
           logEtape5 = Log.AppendFolder("Étape 5: Restore data "); 
            
            //Restore data
		    DeleteModelByName(mod_2239)
            
  	        //Fermer le processus Croesus
            Terminate_CroesusProcess();         
        
    }
}




function Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_SubtitutionTypeComplement()
{
  if (language=="french"){return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Complément"], 10)}
  else {return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Complement"], 10)}
}

function Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_SubtitutionTypeReplacement()
{
  if (language=="french"){return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Remplacement"], 10)}
  else {return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Replacement"], 10)}
}



function Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_SubtitutionTypeFallback()
{
  if (language=="french"){return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Rechange"], 10)}
  else {return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Fallback"], 10)}
}

