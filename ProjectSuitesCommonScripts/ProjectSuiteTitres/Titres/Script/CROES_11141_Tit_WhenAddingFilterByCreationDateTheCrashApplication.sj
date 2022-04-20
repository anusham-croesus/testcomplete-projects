//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
         L'anomalie:CROES-11141
         
         
        1. Se connecter avec Copern 
        2. Module Clients / Sélectionner un client (le client devrait avoir des notes ajouter) / Info / Notes 
        3. Dans le filtre rapide sélectionner l'option 'Date de creation' / Opérateur: n'égale(e) pas / Valeur:  saisir une date 
        4. Appuyer sur le bouton Appliquer --> L'application crash

        *Modules impacté: Module, Relations, Comptes, Portefeuile,Titres.

        Tester sur la version: qa20-Mainline, 90.09-7
        Voir le fichier ci-joint: Croes_Crash_Filtre_Note_Date_creation.PNG
        
    Auteur : Sana Ayaz
    Version de scriptage:ref90-09-Er-12--V9-croesus-co7x-1_5_550
*/
function CROES_11141_Tit_WhenAddingFilterByCreationDateTheCrashApplication()
{
  try {
        
        Log.Link("https://jira.croesus.com/browse/CROES-11141");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Mettre la PREF_EDIT_SECURITY_NOTE  a YES
       Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_SECURITY_NOTE","YES",vServerTitre);
       RestartServices(vServerTitre);
        //Se connecter avec COPERN
        Login(vServerTitre, userNameCOPERN, passwordCOPERN, language);
       
       var DescrSecurityCROES_7801=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "DescrSecurityCROES_7801", language+client);
       var titrTextAddNotTestCROES11141=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "titrTextAddNotTestCROES11141", language+client);
       var descriptionFiltreCreatioDateCROES11141=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "descriptionFiltreCreatioDateCROES11141", language+client);
      
       Get_ModulesBar_BtnSecurities().Click();
       Get_MainWindow().Maximize();    
       Search_SecurityByDescription(DescrSecurityCROES_7801)
       Get_SecurityGrid().Find("Value",DescrSecurityCROES_7801,10).Click();
       Get_SecuritiesBar_BtnInfo().Click();
       Get_WinInfoSecurity_Notes().Click();
       Get_WinInfo_Notes_TabGrid_BtnAdd().Click()
       Get_WinCRUANote().WaitProperty("Enabled", true, 30000);
       Get_WinCRUANote_GrpNote_TxtNote().Click()
       Get_WinCRUANote_GrpNote_TxtNote().Keys(titrTextAddNotTestCROES11141);
       Get_WinCRUANote_BtnSave().Click();
        //Les points de vérifications
         
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, titrTextAddNotTestCROES11141);
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, titrTextAddNotTestCROES11141);
        var textNotCROES11141= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(titrTextAddNotTestCROES11141), 10)
        var x=textNotCROES11141.Exists;
        Log.Message(x);
        if(textNotCROES11141.Exists && textNotCROES11141.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
          
         }
        Get_WinInfoSecurity_BtnOK().Click();
        Search_SecurityByDescription(DescrSecurityCROES_7801)
        Get_SecurityGrid().Find("Value",DescrSecurityCROES_7801,10).Click();
        Get_SecuritiesBar_BtnInfo().Click();
        Get_WinInfoSecurity_Notes().Click();
         /*6- Cliquer sur filtre et choisir le filtre 'Note': La liste des filtres s'ouvre correctement et la fenêtre 'Créer un filtre'
            de 'Note' est ouverte.*/
            Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10);
            Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_CreationDate().Click()
            Get_WinCreateFilter_CmbOperator().Click()
            Get_WinCRUFilter_CmbOperator_ItemIsNotEqualTo().Click();
            Get_WinCreateFilter_DtpValue().Click();
            if(language == "french")
            {
            var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d")
            }
            if(language == "english")
            {
              var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y")
            }
            
            Get_WinCreateFilter_DtpValue().Keys(ToDay);
            Get_WinCreateFilter_BtnApply().Click();
			Log.Message("CROES-11141")
            var displayFiltrecreation=aqString.Concat(descriptionFiltreCreatioDateCROES11141, ToDay)
            
           //Les points de vérification 
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, displayFiltrecreation);
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  */
		Log.Message("CROES-11141")
        //Vérifier que les notes dont la date de création est aujourd'hui ne sont pas affichées
        var  ExistenceResultatFiltreOnGrill=Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Text",ToDay,10)
           if(ExistenceResultatFiltreOnGrill.Exists)
               if(ExistenceNoteOnGrill.Exists)
                {
                  Log.Error("Le résultat du filtre n'est pas correct")
                }
                else
                {
                 Log.Checkpoint("Le résultat du filtre est correct") 
                }

    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_Note(titrTextAddNotTestCROES11141, vServerTitre)
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_SECURITY_NOTE","NO",vServerTitre);
        RestartServices(vServerTitre);
        Terminate_CroesusProcess();
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Delete_Note(titrTextAddNotTestCROES11141, vServerTitre)
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_SECURITY_NOTE","NO",vServerTitre);
        RestartServices(vServerTitre);
        Terminate_CroesusProcess();
      }  
}
