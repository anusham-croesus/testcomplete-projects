//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C2MO9_Edit_Sleeve
//USEUNIT EnablePrefDataBase
//USEUNIT TCVE_902_Template_Type_WorkTeam

 /* Description : Création d'un gabarit: en faisant une copie + Type Firme + Relier des comptes + Accessibilité + Modification en supprimant un segment
                 À cause d'une anomalie PF-1365 on s'est mis d'accord avec Christine que le cas sera automatisé avec les cibles suivantes :
                  l'étape 2 au lieu de 25.5 
                  
                  16-2020-5-8--V9

Analyste d'automatisation: Youlia Raisper */


function TCVE_912_TemplateCopy_Type_Firme()
{
      try{   
         Log.Link("https://jira.croesus.com/browse/TCVE-912", "Lien du cas de test");
         Log.Link("https://jira.croesus.com/browse/TCVE-931", "Lien de la story");  
         
         var userKEYNEJ =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username") 
         var userLYNCHJ =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LYNCHJ", "username")
                          
         var unifiedManagedAccountTemplates= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "unifiedManagedAccountTemplates", language+client);
         var templateName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "templateName912", language+client);
         //var templateName="AAATemplateTCVE912"
         var modelAmericanEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelAmericanEqui", language+client);
         var modelCanadianEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client); 
         var modelLongTerm=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);        
         var sleeveName1 =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "sleeveName1_912", language+client);
         var sleeveName2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "sleeveName2_912", language+client);
         var sleeveName3=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "sleeveName3_912", language+client);
         var targetSleeve1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "targetSleeve1_912", language+client);
         var targetSleeve2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "targetSleeve2_912", language+client);
         var targetSleeve3=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "targetSleeve3_912", language+client);
         var copy_912=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "copy_912", language+client);
         var Account800067OB=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "Account800067OB", language+client);
         var avertissementMessage=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "avertissementMessage", language+client);
         
         //*** préconditions ***
         Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
         Activate_Pref_Sleeve("KEYNEJ","YES","YES","YES","YES","YES");                           
         Activate_Inactivate_Pref("KEYNEJ", "PREF_SLEEVES_ALLOW_TEMPLATE_CREATION", "YES", vServerSleeves)
         Activate_Pref_Sleeve("LYNCHJ","YES","YES","YES","YES","YES");                           
         Activate_Inactivate_Pref("LYNCHJ", "PREF_SLEEVES_ALLOW_TEMPLATE_CREATION", "YES", vServerSleeves)
         RestartServices(vServerSleeves);   
                
         /*exécuter la commande du task schedular est exécutée dans Putty  
          mono /usr/lib/finansoft/administrativeconsole/AdministrativeConsoleText.exe --startTaskScheduler*/
         SSHstartTaskSchedule(); 
         
        Log.Message("À cause d'une anomalie PF-1365 on s'est mis d'accord avec Christine que le cas sera automatisé avec les cibles suivantes : l'étape 2 au lieu de 25.5 ;54.5; --> 25 et 55 ");
        Log.Message("Se loguer dans Croesus avec user KEYNEJ");
        Login(vServerSleeves, userKEYNEJ ,psw,language);
  
        Log.Message("*********************************************  L'étape 2 ************************************************************");
        Log.Message("Aller dans Outils/Configurations/ Comptes à gestion unifiée");
        OpenWinUnifiedManagedAccountTemplates(unifiedManagedAccountTemplates);
        
        Get_WinUnifiedManagedAccountTemplates_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
        
        Log.Message("Remplir les champs Nom et Accès.Nom: Gabarit Équipe de travail. Accès Équipe de travail") 
        Get_WinAddUnifiedManagedAccountTemplate_TxtName().Keys(templateName);
        Get_WinAddUnifiedManagedAccountTemplate_CmbAccess().Click();  
        Get_SubMenus().FindChild("DataContext.Level", "WorkGroup",10).Click();
        
        Log.Message("créer 3 segments comme suit");
        Log.Message("Sleeve1: lui associer un modèle et mettre une cible 25.5%");
        Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveName1,"",targetSleeve1,"","",modelCanadianEqui);
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
        
        Log.Message("Sleeve2: lui associer un modèle et mettre une cible 54.5% ");
        Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveName2,"",targetSleeve2,"","",modelAmericanEqui);
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
        
        Log.Message("Sleeve3: lui associer un modèle et mettre une cilbe 20% et sauvegarder*/");
        Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveName3,"",targetSleeve3,"","",modelLongTerm);
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");

        Log.Message("Le gabarit est créé et s'affiche dans la fenêtre 'Gabarits de comptes à gestion unifiée")
        aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("Value",sleeveName1,10), "VisibleOnScreen", cmpEqual, true);  
        aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("Value",sleeveName2,10), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("Value",sleeveName3,10), "VisibleOnScreen", cmpEqual, true);    
        Get_WinAddUnifiedManagedAccountTemplate_BtnSave().Click();
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
        
        Log.Message("********************************************* JIRA: UMA-51 ************************************************************")
        Log.Message("JIRA: UMA-51 VALIDATION DU TRI DANS LA Fenêtre 'Gabarits de comptes à gestion unifiée' ")
        Log.Link("https://jira.croesus.com/browse/UMA-51", "Lien du JIRA");
		Log.Picture(Sys.Desktop, "My Desktop");
        CheckSortOfNameColumn();
        Log.Message("********************************************* JIRA: UMA-51 ************************************************************")
        
        Scroll();
        aqObject.CheckProperty(Get_WinUnifiedManagedAccountTemplates().FindChild("Value",templateName,10), "VisibleOnScreen", cmpEqual, true);
                
        Log.Message("*********************************************  L'étape 3 ************************************************************");
        Log.Message("sélectionner le gabarit créé dans l'étape précédent et cliquer sur le bouton 'Copier'");
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
        Scroll();
        Get_WinUnifiedManagedAccountTemplates().FindChild("Value",templateName,10).Click();
        Get_WinUnifiedManagedAccountTemplates_BtnCopy().Click();
        Get_WinAddUnifiedManagedAccountTemplate_CmbAccess().Click(); 
        
        Log.Message("Modifier le champ Accès pour 'Firme' et sauvegarder"); 
        Get_SubMenus().FindChild("DataContext.Level", "Firm",10).Click();
        Get_WinAddUnifiedManagedAccountTemplate_BtnSave().Click();
        
        Log.Message("Le nouveau gabarit est sauvegardé");
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
        Scroll();
        aqObject.CheckProperty(Get_WinUnifiedManagedAccountTemplates().FindChild("Value",templateName+copy_912,10), "VisibleOnScreen", cmpEqual, true);
        Get_WinUnifiedManagedAccountTemplates().Close();
        Get_WinConfigurations().Close();

        Log.Message("*********************************************  L'étape 4 ************************************************************");
        /*Associer un compte au gabarit créé dans l'étape précédente*/
        Log.Message("Aller au module Compte");
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Sélectionner un compte et mailler vers module Portefeuille");
        Search_Account(Account800067OB);
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value",Account800067OB,10),Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked",true,30000);        
        
        Log.Message("Cliquer sur le bouton 'Segments'");        
        Get_PortfolioBar_BtnSleeves().Click();
        WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
        Log.Message("Cliquer sur le bouton radio 'À partir d'un gabarit'");
        Get_WinManagerSleeves_GrpSleeveCreation_RdoUsingAtemplate().Click(); 
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();  
        
        Log.Message("********************************************* JIRA: UMA-51 ************************************************************")
        Log.Message("JIRA: UMA-51 VALIDATION DU TRI DANS LA Fenêtre 'Gabarits de comptes à gestion unifiée' ")
        Log.Link("https://jira.croesus.com/browse/UMA-51", "Lien du JIRA");
        CheckSortOfNameColumn();
        Log.Message("********************************************* JIRA: UMA-51 ************************************************************") 
                    
        Log.Message("La fenêtre 'Gabarits de compte à gestion unifiée s'affiche avec la liste des gabarits disponibles");
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
        Scroll();
        aqObject.CheckProperty(Get_WinUnifiedManagedAccountTemplates().FindChild("Value",templateName+copy_912,10), "VisibleOnScreen", cmpEqual, true);
        Log.Message("sélectionner le gabarit créé dans l'étape précédente et cliquer sur 'Associer'");
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
        Scroll();
        Get_WinUnifiedManagedAccountTemplates().FindChild("Value",templateName+copy_912,10).Click();
        Get_WinUnifiedManagedAccountTemplates_BtnAssign().Click();
        
        /*Répartir les titres qui se trouvent dans la section 'Titres sous-jacents' sur les 3 segments en utilisant le bouton 'Déplacer' et Sauvegarder*/
        Log.Message("Sélectionner quelques titres dans la section 'Titres sous-jacents' ensuite cliquer sur le bouton 'Déplacer' et 'Ok'");
        SetAutoTimeOut();
        Select_UnderlyingSecurities_WinSleevesManager(5);
        var numTry = 0;
        do {
           Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();      
        } while (!Get_WinMoveSecurities().Exists)
        Get_WinMoveSecurities_BtnOk().Click();
        
        Select_UnderlyingSecurities_WinSleevesManager(5);
        do {
           Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();      
        } while (++numTry < 5 && !Get_WinMoveSecurities().Exists)
        RestoreAutoTimeOut();
        
        Log.Message("dans le menu déroulant du champ 'Vers le segment' sélectionner 'Sleeve2'");   
        Get_WinMoveSecurities_CmbToSleeve().Keys(sleeveName2);
        Get_WinMoveSecurities_BtnOk().Click();
        
        Log.Message("Sélectionner tous les titres restants");
        Get_WinManagerSleeves_GrpUnderlyingSecurities().Click();
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Keys("^a");    
        Log.Message("cliquer sur le bouton 'Déplacer'");
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();  
        Log.Message("dans le menu déroulant du champ 'Vers le segment' sélectionner 'Sleeve3'");   
        Get_WinMoveSecurities_CmbToSleeve().Keys(sleeveName3);
        Get_WinMoveSecurities_BtnOk().Click();
        Log.Message("Cliquer sur Sauvegarder");
        Get_WinManagerSleeves_BtnSave().Click();
        
        
        /*Vérifier que lorsqu'on re-clique sur le bouton Segment dans module Portefeuille, les 3 boutons 'Ajouter', 'Modifier' et 'Supprimer' sont grisés */
        Log.Message("Re-cliquer sur le bouton Segments");
        Get_PortfolioBar_BtnSleeves().Click();
        aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_BtnAdd(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_BtnEdit(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_BtnDelete(), "IsEnabled", cmpEqual, false);
        
        Get_WinManagerSleeves_BtnCancel().Click();
       
        Log.Message("*********************************************  L'étape 5************************************************************");
        Log.Message("Se loguer dans Croesus avec LYNCHJ");
        Login(vServerSleeves, userLYNCHJ ,psw,language);
  
        Log.Message("Aller dans Outils/Configurations/ Comptes à gestion unifiée");
        OpenWinUnifiedManagedAccountTemplates(unifiedManagedAccountTemplates);
                
        Log.Message("sélectionner un gabarit et cliquer sur Modifier");
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
        Scroll();
        Get_WinUnifiedManagedAccountTemplates().FindChild("Value",templateName+copy_912,10).Click();
        Get_WinUnifiedManagedAccountTemplates_BtnEdit().Click();
        
        Log.Message("La fenêtre 'Modifier un gabarit de compte à gestion unifiée' s'affiche.Puisque le user est un firmadm dans la même firme, il peut voir les gabarits de type firme");
        aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("*********************************************  L'étape 6 ************************************************************");
        Log.Message("Sélectionner un segment 'sleeve3' et cliquer sur Supprimer");
        Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("Value",sleeveName3,10).Click();
        Get_WinAddUnifiedManagedAccountTemplate_BtnDelete().Click();
        Log.Message("un message de confirmation de la suppression du segment s'affiche");
        aqObject.CheckProperty(Get_DlgConfirmation(), "VisibleOnScreen", cmpEqual, true);
        
        Get_DlgConfirmation_BtnOk().Click();
        Log.Message("Cliquer sur Appliquer");
        Get_WinAddUnifiedManagedAccountTemplate_BtnSave().Click();
        
        aqObject.CheckProperty(Get_DlgConfirmation(), "VisibleOnScreen", cmpEqual, true);
        Get_DlgConfirmation_BtnOk().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd",10)
        
        Log.Message("*********************************************  L'étape 7 ************************************************************");       
        Log.Message("Cliquer sur le gabarit ensuite sur le bouton 'Supprimer'");
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
        Scroll();
        Get_WinUnifiedManagedAccountTemplates().FindChild("Value",templateName+copy_912,10).Click();
        Get_WinUnifiedManagedAccountTemplates_BtnDelete().Click();
        
        Log.Message("un message d'avertissement s'affiche: Ce gabarit ne peut pas être supprimé car il est assigné à au moins un compte à gestion unifiée");        
        aqObject.CheckProperty(Get_DlgWarning(), "CommentTag", cmpEqual,avertissementMessage);
        Get_DlgWarning_BtnOK().Click();
        Get_WinUnifiedManagedAccountTemplates().Close();
        Get_WinConfigurations().Close();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {
        //*********************************************************réinitialiser les donnes************************************************
        Log.Message("Se loguer dans Croesus avec user KEYNEJ");
        Login(vServerSleeves, userKEYNEJ ,psw,language);
        Log.Message("Attendre de 2 à 4 mins");
        Delay(500000);
        
        Log.Message("Aller au module Compte");
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Sélectionner un compte et mailler vers module Portefeuille");
        Search_Account(Account800067OB);
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value",Account800067OB,10),Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked",true,30000);
        
        Log.Message("Cliquer sur le bouton 'Segments'");        
        Get_PortfolioBar_BtnSleeves().Click();
        SetAutoTimeOut();
        if(Get_DlgError().Exists){
          Log.Error("Le message ne devrait plus apparaître"); 
        }else{          
          Log.Message("Cliquer sur le bouton radio 'MANUELLE'");
          Get_WinManagerSleeves_GrpSleeveCreation_RdoManual().Click();
        
          Log.Message("Cliquer sur le bouton supprimer");
          Get_DlgConfirmation_BtnCancel().Click();
          Get_WinManagerSleeves_BtnSave().Click(); 
        };
        RestoreAutoTimeOut();
        
        //Supprimer le gabarit
        OpenWinUnifiedManagedAccountTemplates(unifiedManagedAccountTemplates);
        DeleteTemplate(templateName);
        DeleteTemplate(templateName+copy_912);
        
        Get_WinUnifiedManagedAccountTemplates().Close();
        Get_WinConfigurations().Close(); 
        
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}
function Scroll(){
  var scrollBarX = Get_WinUnifiedManagedAccountTemplates().Width - 25;
  var scrollBarY = Get_WinUnifiedManagedAccountTemplates().Height - 100;	
	Get_WinUnifiedManagedAccountTemplates().Click(scrollBarX, scrollBarY);
}

function CheckSortOfNameColumn(){
  Get_WinUnifiedManagedAccountTemplates_DgTemplates_ChName().Click()
  Check_columnAlphabeticalSort_CR1483( Get_WinUnifiedManagedAccountTemplates_DgTemplates(), "Nom", "Name" )
  Get_WinUnifiedManagedAccountTemplates_DgTemplates_ChName().Click()
  Check_columnAlphabeticalSort_CR1483( Get_WinUnifiedManagedAccountTemplates_DgTemplates(), "Nom", "Name" )
 
}

function  Get_WinUnifiedManagedAccountTemplates_DgTemplates_ChName()
{
  if (language == "french"){return Get_WinUnifiedManagedAccountTemplates_DgTemplates().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}