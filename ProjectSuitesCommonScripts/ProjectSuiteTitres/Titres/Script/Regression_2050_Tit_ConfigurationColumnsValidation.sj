//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA 

/**
    
    Description : Valider le fonctionnement des colonnes configurables dans le module Titres
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2050   
    Analyste d'automatisation : Amine Alaoui 
   
    ---------------------
    Étape 9 de cas de test :
    Automatiser Jira BNC-2291 --  https://jira.croesus.com/browse/BNC-2291    
    Analyste d'automatisation : Emna IHM
    Version = ref90.10.Fm-19
    
*/

function Regression_2050_Tit_ConfigurationColumnsValidation(){
 
    try{            
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2050");
        
        var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");            
        
        var defaultGroupBox=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "DefaultGroupBox", language+client); //Défaut
        var analystCoverage=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2083", "AnalystCoverage", language+client);//"Suivi des analystes"
            
        Log.Message("**********************Login********************");
        Login(vServerTitre, userNameKeynej, passwordKeynej, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnSecurities().Click();        
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000);
        
        Log.Message("*** Ajouter la colonne 'Bourse'  ***");                 
        if (!Get_SecurityGrid_ChMarket().Exists){            
            Get_SecurityGrid_ChSymbol().ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();              
            Get_GridHeader_ContextualMenu_AddColumn_Market().Click();         
            }
        aqObject.CheckProperty(Get_SecurityGrid_ChMarket(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_SecurityGrid_ChMarket(), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_SecurityGrid_ChMarket(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("*****  Ajoter le champs Écheance  *********");                 
        if (!Get_SecurityGrid_ChMaturity().Exists){            
            Get_SecurityGrid_ChSymbol().ClickR();
            Get_GridHeader_ContextualMenu_InsertField().OpenMenu();              
            Get_GridHeader_ContextualMenu_InsertField_MaturityDate().Click();         
            }
        aqObject.CheckProperty(Get_SecurityGrid_ChMaturity(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_SecurityGrid_ChMaturity(), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_SecurityGrid_ChMaturity(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("**** Enlever la colonne 'Bourse' ****");                 
        // Si la colonne 'Bourse' est affichée on l'enlève
        if (Get_SecurityGrid_ChMarket().Exists){            
            Get_SecurityGrid_ChMarket().ClickR();
            Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();         
            }
        aqObject.CheckProperty(Get_SecurityGrid_ChMarket(), "Exists", cmpEqual, false);
        
        Log.Message("**** Enlever le champs Écheance  ***********");
        // Si le champs 'Écheance' est affichée on l'enlève
        if (Get_SecurityGrid_ChMaturity().Exists){            
            Get_SecurityGrid_ChMaturity().ClickR();
            Get_GridHeader_ContextualMenu_RemoveThisField().Click();         
            }    
        aqObject.CheckProperty(Get_SecurityGrid_ChMaturity(), "Exists", cmpEqual, false);
        
        Log.Message("****** Rendre la colonne 'Symbol' Mobile*********");
        if (Get_SecurityGrid_ChSymbol().Exists){
            Get_SecurityGrid_ChSymbol().ClickR();
            Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
            Get_GridHeader_ContextualMenu_ColumnStatus_Movable().Click();
            aqObject.CheckProperty(Get_SecurityGrid_ChSymbol(), "IsFixed", cmpEqual, false);         
            } 
        Log.Message("******  Rendre la colonne 'Devise prix' fix à droite  ********");
        if (Get_SecurityGrid_ChCurrencyPrice().Exists){            
            Get_SecurityGrid_ChCurrencyPrice().ClickR();
            Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
            Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheRight().Click(); 
            aqObject.CheckProperty(Get_SecurityGrid_ChCurrencyPrice(), "IsFixed", cmpEqual, true);       
            }   
        Get_SecurityGrid_ChSecurity().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().ClickR();
        
        
        Log.Message("***** Remplacer la colonne 'Type' par la colonne 'Dividende' ******");
        if (Get_SecurityGrid_ChType().Exists && (!Get_SecurityGrid_ChDividend().Exists)){
            Get_SecurityGrid_ChType().ClickR();
            Get_GridHeader_ContextualMenu_ReplaceColumnWith().Click();
            Get_GridHeader_ContextualMenu_AddColumn_Dividend().Click();   
            aqObject.CheckProperty(Get_SecurityGrid_ChType(), "Exists", cmpEqual, false);
            aqObject.CheckProperty(Get_SecurityGrid_ChDividend(), "Visible", cmpEqual, true);
            aqObject.CheckProperty(Get_SecurityGrid_ChDividend(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_SecurityGrid_ChDividend(), "VisibleOnScreen", cmpEqual, true);
        }
        
        
        //*** Partie automatisé par Emna IHM -- Version Fm-19 ***//
        Log.Message("***** Valider le jira  BNC-2291 ******");        
        Log.Link("https://jira.croesus.com/browse/BNC-2291", "Lien sur Jira : BNC-2291"); //lien pour Jira
        
        Log.Message("** Faire info titre  et cliquer sur l'onglet Profils")
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        Get_WinInfoSecurity_TabProfiles().Click();
        Get_WinInfoSecurity_TabProfiles().WaitProperty("IsSelected",true, 15000);
        
        Log.Message("** Cliquer sur Configuration... et cocher le profil "+analystCoverage+" + Sauvegarder"); 
        Get_WinInfoSecurity_TabProfiles_ChkHideEmptyProfiles().set_IsChecked(false);
        Get_WinInfoSecurity_TabProfiles_BtnSetup().Click();  
        profileCheckbox = Get_WinVisibleProfilesConfiguration_ChkProfile(analystCoverage);
        if(profileCheckbox.get_IsChecked() == false)
            profileCheckbox.Click();        
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        
        Log.Message("** Valider que le combo du profil "+analystCoverage+" existe")
        var profileCombo = Get_WinInfoSecurity().FindChild(["ClrClassName", "WPFControlText"], ["Expander", defaultGroupBox], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContentControl", "1"], 10).WPFObject("ComboValue")
        aqObject.CheckProperty(profileCombo, "Exists", cmpEqual, true);
        Get_WinInfoSecurity_BtnOK().Click();
        
        Log.Message("** Faire un right click sur la l'entête de la colonne + Ajouter une colonne -- Amener le curseur sur Profils et valider qu'il est disponible")
        Get_SecurityGrid_ChSymbol().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu(); 
        Get_GridHeader_ContextualMenu_AddColumn_Profiles().Click();
        aqObject.CheckProperty(Get_GridHeader_ContextualMenu_AddColumn_Profiles(), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_GridHeader_ContextualMenu_AddColumn_Profiles(), "VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_GridHeader_ContextualMenu_AddColumn_Profiles(), "Enabled", cmpEqual, true);
        
        Log.Message("************************************************* CLEANUP *************************************************")
        RestoreData(analystCoverage)
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
        
    }
    catch (e) {            
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        
        Log.Message("************************************************* CLEANUP *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnSecurities().Click();        
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000);
        RestoreData(analystCoverage);  
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();                
    }         
    finally {           
       // Close Croesus 
       Terminate_CroesusProcess();        
       }                    
}

function RestoreData(profile){      
        
        Log.Message("Faire info titre  et cliquer sur l'onglet Profils")
        Get_SecuritiesBar_BtnInfo().Click();
        Get_WinInfoSecurity_TabProfiles().Click();        
        
        Log.Message("Cliquer sur Configuration... et décocher le profil "+profile+" + Sauvegarder"); 
        Get_WinInfoSecurity_TabProfiles_ChkHideEmptyProfiles().set_IsChecked(false);
        
        Get_WinInfoSecurity_TabProfiles_BtnSetup().Click();  
        profileCheckbox = Get_WinVisibleProfilesConfiguration_ChkProfile(profile);
        if(profileCheckbox.get_IsChecked() == true)
            profileCheckbox.Click();        
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        Get_WinInfoSecurity_BtnOK().Click();
}