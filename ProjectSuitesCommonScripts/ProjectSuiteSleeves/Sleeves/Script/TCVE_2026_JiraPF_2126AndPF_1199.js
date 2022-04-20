//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT TCVE_902_Template_Type_WorkTeam



 /* Description :En tant que RTE 

Je veux automatiser  le Jira PF-2126  dans une Bd QA interne (BNC)

Afin que cette fonctionnalité soit couverte dans nos tests auto du module Sleeves/ Gabarits

À noter que ce même problème a été soulevé dans le PF-1199 par les cas de tests manuels de l'équipe TCVE

( les cas de tests à automatiser sont dans  la section Reproduce du  Jira (PF-1199)
                 
Analyste d'automatisation: Sana Ayaz */


function TCVE_2026_JiraPF_2126AndPF_1199()
{
      try{   
         Log.Link("https://jira.croesus.com/browse/PF-1199", "Lien de l'anomalie");
         Log.Link("https://jira.croesus.com/browse/TCVE-2026", "Lien de la story");  
         
         var user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                  
         var unifiedManagedAccountTemplates= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "unifiedManagedAccountTemplates", language+client);
         var templateNameTCVE2026=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "templateNameTCVE2026", language+client);
         var targetSleeveTCVE2026=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "targetSleeveTCVE2026", language+client);
         var modelCanadianEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client); 
         var modelMoyenTerme=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelMoyenTerme", language+client);
         var sleeveNameTCVE2026 =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "sleeveNameTCVE2026", language+client);
         var minTCVE2026=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "minTCVE2026", language+client);
         var targetSleeveTCVE2026Step6=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "Templates", "targetSleeveTCVE2026Step6", language+client);

/************************************Étape 1************************************************************************/     
           //Se connecter à croesus avec Keynej
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1:  PREF_SLEEVE_AUTO_CASH_MANAGEMENT=Yes,PREF_SLEEVES_ALLOW_TEMPLATE_CREATION=Yes pour KEYNEJ");
            
         Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
         Activate_Inactivate_Pref(user, "PREF_SLEEVE_AUTO_CASH_MANAGEMENT", "YES", vServerSleeves)      
         Activate_Inactivate_Pref(user, "PREF_SLEEVES_ALLOW_TEMPLATE_CREATION", "YES", vServerSleeves)
         RestartServices(vServerSleeves);   
 
/************************************Étape 2************************************************************************/     
           //Se connecter à croesus avec Keynej
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Se connecter à croesus avec Keynej");
               
          Log.Message("Se loguer dans Croesus avec user KEYNEJ");
          Login(vServerSleeves, user ,psw,language);
  
        Log.Message("*********************************************  L'étape 3 ************************************************************");
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Aller dans Outils, Configuration, Comptes a gestion unifièe");
          Log.Message("Aller dans Outils/Configurations/")
          OpenWinUnifiedManagedAccountTemplates(unifiedManagedAccountTemplates);
        
         Get_WinUnifiedManagedAccountTemplates_BtnAdd().Click();
         WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
        Log.Message("*********************************************  L'étape 4 ************************************************************");
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Ajouter un gabarit, ajouter un segments sans lui associer un modèle puis sauvegarder");
        Log.Message("Remplir les champs Nom et Accès.Nom: Gabarit TCVE2026. Accès:  Succursale") 
        Get_WinAddUnifiedManagedAccountTemplate_TxtName().Keys(templateNameTCVE2026);
        Get_WinAddUnifiedManagedAccountTemplate_CmbAccess().Click();  
        Get_SubMenus().FindChild("DataContext.Level", "Branch",10).Click();
        Log.Message("Cliquer sur le bouton 'Ajouter' et créer un segment")
        Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();
        
        Log.Message("Sleeve: lui associer un modèle et mettre une cible 30%");
        AddEditSleeveWinSleevesManager(sleeveNameTCVE2026,"",targetSleeveTCVE2026,minTCVE2026,"","");
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
        Get_WinAddUnifiedManagedAccountTemplate_BtnSave().Click();
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
	      Scroll();
        Log.Message("*********************************************  L'étape 5 ************************************************************");
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Modifier le gabarit déja créé (lui associer un modèle) puis sauvegarder");
        Get_WinUnifiedManagedAccountTemplates_DgTemplates().FindChild("Value",templateNameTCVE2026,10).Click();
        Get_WinUnifiedManagedAccountTemplates_BtnEdit().Click();
        WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");

        Log.Message("Sélectionner le sleeve déja créé et cliquer sur le bouton Modifier ");
        do {
           Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("Value",sleeveNameTCVE2026,10).Click();     
        } while (!Get_WinAddUnifiedManagedAccountTemplate_BtnEdit().IsEnabled)
        Get_WinAddUnifiedManagedAccountTemplate_BtnEdit().Click();
        Log.Message("Associer un modèle au sleeve puis sauvegarder");
        AddEditSleeveWinSleevesManager(sleeveNameTCVE2026,"","","","",modelCanadianEqui);
        Get_WinAddUnifiedManagedAccountTemplate_BtnSave().Click();
        SetAutoTimeOut();
         if (Get_DlgError().Exists){
           Log.Error("L'anomalie :PF-1199")
           Log.Message("On reproduis l'anomalie sur tout version de mois que 2020.3-162 d'après Christine H")
         
       
         }
        
        if (!Get_DlgError().Exists){
        Log.Message("*********************************************  L'étape 6 ************************************************************");
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: lorsque le gabarit est sauvegardé sans erreur, recliquer sur Modifier le gabarit et enlever le modèle existant ensuite relier un autre modèle, modifier le % cible et sauvegarder ");
        Log.Checkpoint("Il y a pas l'anomalie PF-1199")
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
	      Scroll();
        Get_WinUnifiedManagedAccountTemplates_DgTemplates().FindChild("Value",templateNameTCVE2026,10).Click();
        Get_WinUnifiedManagedAccountTemplates_BtnEdit().Click();
        WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
         Log.Message("Sélectionner le sleeve déja créé et cliquer sur le bouton Modifier ");
        do {
           Get_WinAddUnifiedManagedAccountTemplate_DgSleeves().FindChild("Value",sleeveNameTCVE2026,10).Click();     
        } while (!Get_WinAddUnifiedManagedAccountTemplate_BtnEdit().IsEnabled)
        Get_WinAddUnifiedManagedAccountTemplate_BtnEdit().Click();
        Log.Message("enlever le modèle existant ensuite relier un autre modèle, modifier le % cible ")
        AddEditSleeveWinSleevesManager(sleeveNameTCVE2026,"",targetSleeveTCVE2026Step6,"","",modelMoyenTerme);
        Get_WinAddUnifiedManagedAccountTemplate_BtnSave().Click();
        }
        
        RestoreAutoTimeOut();



    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {
        //*********************************************************réinitialiser les donnes************************************************
         Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
        Log.Message("Se loguer dans Croesus avec user KEYNEJ");
        Login(vServerSleeves, user ,psw,language);

        
        //Supprimer le gabarit
        OpenWinUnifiedManagedAccountTemplates(unifiedManagedAccountTemplates);
        Get_WinUnifiedManagedAccountTemplates().parent.Maximize();
	      Scroll();
        
         do {
           Get_WinUnifiedManagedAccountTemplates().FindChild("Value",templateNameTCVE2026,10).Click();
        
        } while (!Get_WinUnifiedManagedAccountTemplates_BtnDelete().IsEnabled)
        
      
        Get_WinUnifiedManagedAccountTemplates_BtnDelete().Click();
        
    
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