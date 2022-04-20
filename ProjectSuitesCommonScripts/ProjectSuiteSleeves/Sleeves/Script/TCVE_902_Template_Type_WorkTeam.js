//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C2MO9_Edit_Sleeve
//USEUNIT EnablePrefDataBase


 /* Description : Création d'un gabarit (Type: Équipe de travail) + Relier des comptes + Modification	
                 À cause d'une anomalie PF-1365 on s'est mis d'accord avec Christine que le cas sera automatisé avec les cibles suivantes : 
                 l'étape 2  au lieu de 25.5 ; 74.5 --> 25 et 75 ; l'étape 8 au lieu de 54.5 --> 55 
                 
                 16-2020-5-8--V9
                 
Analyste d'automatisation: Youlia Raisper */


function TCVE_902_Template_Type_WorkTeam()
{
      try{   
         Log.Link("https://jira.croesus.com/browse/TCVE-902", "Lien du cas de test");
         Log.Link("https://jira.croesus.com/browse/TCVE-931", "Lien de la story");  
         
         var user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                  
         var unifiedManagedAccountTemplates= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "unifiedManagedAccountTemplates", language+client);
         var templateName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "templateName", language+client);
         //var templateName="AAATemplateTCVE902"
         var modelAmericanEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelAmericanEqui", language+client);
         var modelCanadianEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client); 
         var modelMoyenTerme=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelMoyenTerme", language+client);
         var sleeveName1 =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "sleeveName1", language+client);
         var sleeveName2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "sleeveName2", language+client);
         var sleeveName3=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "sleeveName3", language+client);
         var targetSleeve1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "targetSleeve1", language+client);
         var targetSleeve2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "targetSleeve2", language+client);
         var targetSleeve3=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "targetSleeve3", language+client);
         var newTargetSleeve2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "newTargetSleeve2", language+client);
         var ratio1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "ratio1", language+client);
         var ratio2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "ratio2", language+client);
         var Account800068NA=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "Account800068NA", language+client);
         var confirmationMessage=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "confirmationMessage", language+client);
         var warningMessage=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "warningMessage", language+client);
         var sleeve1_Modified =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "sleeveName1_Modified", language+client);
         var sleeve2_Modified =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "sleeveName2_Modified", language+client); 
         
         //*** préconditions ***
         Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
         Activate_Pref_Sleeve(user,"YES","YES","YES","YES","YES");                           
         Activate_Inactivate_Pref(user, "PREF_SLEEVES_ALLOW_TEMPLATE_CREATION", "YES", vServerSleeves)
         RestartServices(vServerSleeves);   
                
         /*exécuter la commande du task schedular est exécutée dans Putty  
          mono /usr/lib/finansoft/administrativeconsole/AdministrativeConsoleText.exe --startTaskScheduler*/
         SSHstartTaskSchedule(); 
        Log.Message("À cause d'une anomalie PF-1365 on s'est mis d'accord avec Christine que le cas sera automatisé avec les cibles suivantes : l'étape 2  au lieu de 25.5 ; 74.5 --> 25 et 75 ; l'étape 8 au lieu de 54.5 --> 55 ");
        Log.Message("Se loguer dans Croesus avec user KEYNEJ");
        Login(vServerSleeves, user ,psw,language);
  
        Log.Message("*********************************************  L'étape 2 ************************************************************");
        Log.Message("Aller dans Outils/Configurations/")
        OpenWinUnifiedManagedAccountTemplates(unifiedManagedAccountTemplates);
        
        Get_WinUnifiedManagedAccountTemplates_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
        Log.Message("*********************************************  L'étape 3 ************************************************************");
        Log.Message("Remplir les champs Nom et Accès.Nom: Gabarit Équipe de travail. Accès Équipe de travail") 
        Get_WinAddUnifiedManagedAccountTemplate_TxtName().Keys(templateName);
        Get_WinAddUnifiedManagedAccountTemplate_CmbAccess().Click();  
        Get_SubMenus().FindChild("DataContext.Level", "WorkGroup",10).Click();
        
        Log.Message("*********************************************  L'étape 4 ************************************************************");
        Log.Message("Cliquer sur le bouton 'Ajouter' et créer 2 segments")
        Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();
        
        Log.Message("Sleeve1: lui associer un modèle et mettre une cible 25.5%");
        AddEditSleeveWinSleevesManager(sleeveName1,"",targetSleeve1,"","",modelAmericanEqui);
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
        
        Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();
        Log.Message("Sleeve2: lui associer un modèle et mettre une cible 74.5% et sauvegarder");
        AddEditSleeveWinSleevesManager(sleeveName2,"",targetSleeve2,"","",modelCanadianEqui);
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");

        Log.Message("Le gabarit est créé et s'affiche dans la fenêtre 'Gabarits de comptes à gestion unifiée")
        aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("Value",sleeveName1,10), "VisibleOnScreen", cmpEqual, true);  
        aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("Value",sleeveName2,10), "VisibleOnScreen", cmpEqual, true);    
        Get_WinAddUnifiedManagedAccountTemplate_BtnSave().Click();
        
        Get_WinUnifiedManagedAccountTemplates().Close();
        Get_WinConfigurations().Close();
        
        Log.Message("*********************************************  L'étape 5 ************************************************************");
        Log.Message("Aller au module Compte");
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Sélectionner un compte et mailler vers module Portefeuille");
        Search_Account(Account800068NA);
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value",Account800068NA,10),Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked",true,30000);        
        
        Log.Message("Cliquer sur le bouton 'Segments'");        
        Get_PortfolioBar_BtnSleeves().Click();
        WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
        Log.Message("Cliquer sur le bouton radio 'À partir d'un gabarit'");
        Get_WinManagerSleeves_GrpSleeveCreation_RdoUsingAtemplate().Click();   
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();             
        Log.Message("La fenêtre 'Gabarits de compte à gestion unifiée s'affiche avec la liste des gabarits disponibles");
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
	      Scroll();
        aqObject.CheckProperty(Get_WinUnifiedManagedAccountTemplates().FindChild("Value",templateName,10), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("*********************************************  L'étape 6 ************************************************************");
        Log.Message("sélectionner le gabarit créé dans l'étape précédente et cliquer sur 'Associer'");
        Get_WinUnifiedManagedAccountTemplates().FindChild("Value",templateName,10).Click();
        Get_WinUnifiedManagedAccountTemplates_BtnAssign().Click();
        Log.Message("Le nom du gabarit s'affiche dans le champ 'À partir d'un gabarit' et les segments du gabarit apparaissent avec leur cibles et modèles associés");
        Get_WinManagerSleeves().Parent.Maximize();
        aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeveCreation_RdoUsingAtemplate(), "IsChecked", cmpEqual, true);
        aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeveCreation_TxtUsingAtemplate(), "Text", cmpEqual, templateName);
        aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("value",sleeveName1,10).DataContext.DataItem, "ModelName", cmpEqual, modelAmericanEqui);
        aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("value",sleeveName1,10).DataContext.DataItem, "Ratio", cmpEqual, ratio1);
        aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("value",sleeveName2,10).DataContext.DataItem, "ModelName", cmpEqual, modelCanadianEqui);
        aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("value",sleeveName2,10).DataContext.DataItem, "Ratio", cmpEqual, ratio2);
        Log.Message("Cliquer sur Sauvegarder");
        Get_WinManagerSleeves_BtnSave().Click();
        
        Log.Message("*********************************************  L'étape 7 ************************************************************");
        Log.Message("Re-cliquer sur le bouton Segments");
        Get_PortfolioBar_BtnSleeves().Click();
        Log.Message("Sélectionner quelques titres dans la section 'Titres sous-jacents' ensuite cliquer sur le bouton 'Déplacer' et 'Ok'");

        SetAutoTimeOut();
        Select_UnderlyingSecurities_WinSleevesManager(10);
        var numTry = 0;
        do {
           Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();      
        } while (++numTry < 5 && !Get_WinMoveSecurities().Exists)
        Get_WinMoveSecurities_BtnOk().Click();
        RestoreAutoTimeOut();
        
        Log.Message("Sélectionner tous les titres restants");
        Get_WinManagerSleeves_GrpUnderlyingSecurities().Click();
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Keys("^a");    
        Log.Message("cliquer sur le bouton 'Déplacer'");
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();  
        Log.Message("dans le menu déroulant du champ 'Vers le segment' sélectionner 'Sleeve2'");   
        Get_WinMoveSecurities_CmbToSleeve().Keys(sleeveName2);
        Get_WinMoveSecurities_BtnOk().Click();
        Log.Message("Cliquer sur Sauvegarder");
        Get_WinManagerSleeves_BtnSave().Click();
        
        Log.Message("*********************************************  L'étape 8 ************************************************************");
       
        Log.Message("Retourner à Outils/ Configurations/ Comptes à gestion unifiée");
        Log.Message("cliquer sur 'Gabarits de comptes à gestion unifiée' et sélectionner le gabarit créé précédemment.");
        OpenWinUnifiedManagedAccountTemplates(unifiedManagedAccountTemplates);
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
        Scroll(); 
        Get_WinUnifiedManagedAccountTemplates_DgTemplates().FindChild("Value",templateName,10).Click();
        Get_WinUnifiedManagedAccountTemplates_BtnEdit().Click();
        WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
        
        //Etape modifié suite a la TCVE-5527 (pour plus de details voir la TCVE-5527)
        Log.Message("Sélectionner le segment 'Sleeve2' , modifier son nom:  et sa cilbe  % cible à 54.5%,puis le segment sleeve1 modifier son nom");
        var numTry = 0;
        do {
           Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("Value",sleeveName2,10).Click();     
        } while (++numTry < 5 && !Get_WinAddUnifiedManagedAccountTemplate_BtnEdit().IsEnabled)

        Get_WinAddUnifiedManagedAccountTemplate_BtnEdit().Click();
        WaitObject(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
        Get_WinEditSleeve_TxtSleeveDescription().set_Text(sleeve2_Modified); 
        Get_WinEditSleeve_TxtTargerPercent().Clear();
        Get_WinEditSleeve_TxtTargerPercent().set_Text(newTargetSleeve2);
        Get_WinEditSleeve_BtOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
        
        Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("Value",sleeveName1,10).Click();     
        Get_WinAddUnifiedManagedAccountTemplate_BtnEdit().Click();
        WaitObject(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
        Get_WinEditSleeve_TxtSleeveDescription().set_Text(sleeve1_Modified); 
        Get_WinEditSleeve_BtOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
        
        Log.Message("Cliquer sur Ajouter pour créer un nouveau segment 'Sleeve3', mettre une cible 20% et relier un modèle");
        Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveName3,"",targetSleeve3,"","",modelMoyenTerme);
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
        Get_WinAddUnifiedManagedAccountTemplate_BtnSave().Click();//Appliquer
        
        //Validation de message 
        aqObject.CheckProperty(Get_DlgConfirmation_LblMessage1(), "Text", cmpEqual, confirmationMessage);
        Get_DlgConfirmation_BtnOk().Click();
        
        Log.Message("*********************************************  L'étape 10 ************************************************************");       
        Log.Message("Re-cliquer sur le bouton 'Modifier' pour tenter de modifier le gabarit");
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
        Scroll(); 
        Get_WinUnifiedManagedAccountTemplates_DgTemplates().FindChild("Value",templateName,10).Click();
        Get_WinUnifiedManagedAccountTemplates_DgTemplates().FindChild("Value",templateName,10).Click();
        Get_WinUnifiedManagedAccountTemplates_BtnEdit().Click();
               
        Log.Message("Un message d'avertissement nous avisant que le gabarit est en cours de modification s'affiche");
        aqObject.CheckProperty(Get_DlgWarning(), "CommentTag", cmpEqual,warningMessage);
        Get_DlgWarning_BtnOK().Click();
        
        Log.Message("*********************************************  L'étape 11 ************************************************************");
        Log.Message("Attendre de 2 à 4 mins");
        Delay(500000);
               
        Log.Message("Re-cliquer sur le bouton 'Modifier' pour tenter de modifier le gabarit");
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
        Scroll(); 
        Get_WinUnifiedManagedAccountTemplates_DgTemplates().FindChild("Value",templateName,10).Click();
        Get_WinUnifiedManagedAccountTemplates_BtnEdit().Click();
        Log.Message("Le message ne devrait plus apparaître et la fenêtre Modifier un gabarit..' devrait apparaître");
        
        SetAutoTimeOut();
        if( Get_DlgWarning().Exists){
          Log.Error("Le message ne devrait plus apparaître. Jira: PF-1365");  
          Get_DlgWarning_BtnOK().Click();
          Get_WinUnifiedManagedAccountTemplates().Close();
          Get_WinConfigurations().Close();
            
        }else{
          Log.Checkpoint("la fenêtre Modifier un gabarit..' devrait apparaître");
          Get_WinAddUnifiedManagedAccountTemplate().Close();
          Get_WinUnifiedManagedAccountTemplates().Close();
          Get_WinConfigurations().Close();
        }
        RestoreAutoTimeOut();
                
        Log.Message("*********************************************  L'étape 12 ************************************************************");
        Log.Message("Vérifier lorsqu'on clique sur le bouton segment dans le module Portefeuille (pour le compte relié au gabarit, dans ce cas le 800068-NA)");
        Log.Message("Cliquer sur le bouton 'Segments'");        
        Get_PortfolioBar_BtnSleeves().Click();
                
        SetAutoTimeOut();
        if(Get_DlgError().Exists){
          Log.Error("Le message ne devrait plus apparaître"); 
        }else{          
          Log.Message("La fenêtre 'Gestionnaire des segments' doit s'afficher correctement");
          WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
          aqObject.CheckProperty(Get_WinManagerSleeves(), "VisibleOnScreen", cmpEqual,true);
          
          //Valider les noms des segment modifier a l'etape 8'
        var grid= Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().WPFObject("RecordListControl", "", 1)
        aqObject.CheckProperty(grid.Items.Item(1).DataItem, "Description", cmpEqual,sleeve1_Modified);
        aqObject.CheckProperty(grid.Items.Item(2).DataItem, "Description", cmpEqual,sleeve2_Modified);
          
        };
        RestoreAutoTimeOut();
        Get_WinManagerSleeves_BtnCancel().CLick();

    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {
        //*********************************************************réinitialiser les donnes************************************************
        Log.Message("Se loguer dans Croesus avec user KEYNEJ");
        Login(vServerSleeves, user ,psw,language);
        
        Log.Message("Aller au module Compte");
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Sélectionner un compte et mailler vers module Portefeuille");
        Search_Account(Account800068NA);
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value",Account800068NA,10),Get_ModulesBar_BtnPortfolio());
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
        
        Get_WinUnifiedManagedAccountTemplates().Close();
        Get_WinConfigurations().Close(); 
              
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}



function Select_UnderlyingSecurities_WinSleevesManager(nbrOfSecuritiesToSelect)
{    
    for(var i=0;i<=nbrOfSecuritiesToSelect ;i++){
             Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
             Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true)      
         }
}

function SSHstartTaskSchedule(){
       //Create PLINK batch file
        var hostname = GetVserverHostName(vServerSleeves);
        var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
        var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m CommandeSSHForTemplate.txt > CommandeSSHForTemplate_output.txt";
        var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteSleeves\\Sleeves\\CommandeSSHForTemplate_plink.bat";
        CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
        //Execute PLINK batch file (The PLINK application must be present in the same folder)
        ExecuteBatchFile(plinkBatchFilePath);
}


function OpenWinUnifiedManagedAccountTemplates(unifiedManagedAccountTemplates){ 
  
    Log.Message("Aller dans Outils/Configurations/")
    Get_MenuBar_Tools().Click();
                      
    SetAutoTimeOut();
    while (! Get_SubMenus().Exists)
      Get_MenuBar_Tools().Click();
    RestoreAutoTimeOut();
        
    Get_MenuBar_Tools_Configurations().Click();
    WaitObject(Get_CroesusApp(), "WindowMetricTag", "CONFIGVIEW");     
         
    Log.Message("Comptes à gestion unifiée/cliquer sur 'Gabarits de comptes à gestion unifiée'Cliquer sur le bouton 'Ajouter'");
    Get_WinConfigurations_TvwTreeview_LlbUnifiedManagedAccounts().Click();
    Get_WinConfigurations_LvwListView_LlbItem(unifiedManagedAccountTemplates).DblCLick();
    WaitObject(Get_CroesusApp(),"Uid","ManagerWindow_730e");
}

function DeleteTemplate(templateName){
    Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
    Scroll();    
    Get_WinUnifiedManagedAccountTemplates().FindChild("Value",templateName,10).Click();
    Get_WinUnifiedManagedAccountTemplates_BtnDelete().Click();
    
}

function Scroll(){
  var scrollBarX = Get_WinUnifiedManagedAccountTemplates().Width - 25;
  var scrollBarY = Get_WinUnifiedManagedAccountTemplates().Height - 100;	
	Get_WinUnifiedManagedAccountTemplates().Click(scrollBarX, scrollBarY);
}