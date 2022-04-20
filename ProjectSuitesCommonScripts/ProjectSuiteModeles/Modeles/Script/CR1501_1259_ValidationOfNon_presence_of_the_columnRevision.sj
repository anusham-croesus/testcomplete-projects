//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
       Préconditions:
       La préférence PREF_ENABLE_REVIEW est a 1.
       Se connecter avec 'COPERN'.
       
       
       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1259
        Description : 
        1-Choisir le module modèle.:le module modèle est ouvert.
        2-Sélectionner un modèle qui contient des notes.:Le modèle est sélectionné.
        3-Cliquer sur le bouton 'Info'.:La fenêtre info modèle est ouverte.
        4-Sélectionner l'onglet grille.:La colonne 'Révision' n'apparait pas parmis la liste des colonnes.
        5-Faire un right-click sur une colonne ensuite cliquer sur ajouter une colonne.:La colonne révision n'apparait pas parmi la liste des colonnes.
        
        

    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-1--V9-Be_1-co6x
*/
function CR1501_1259_ValidationOfNon_presence_of_the_columnRevision()
{
    try {
      
    
    
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1259");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","1",vServerModeles);
        RestartServices(vServerModeles);
        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
       var modelNameCroes940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes940", language+client);
       var modelTextAddNotCROES1259=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES1259", language+client);
    
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        // 4. Créer un nouveau modèle.
         Get_ModulesBar_BtnModels().Click();
         SearchModelByName(modelNameCroes940);
         Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();
         Get_ModelsBar_BtnInfo().Click();
         Get_WinModelInfo_TabNotes().Click();
         Get_WinModelInfo_TabNotes_TabGrid().Click();
         Get_WinModelInfo_TabNotes_TabGrid_BtnAdd().Click();
         WaitObject(Get_CroesusApp(), "Uid", " NoteDetailWindow_2d5e");
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES1259);
          Get_WinCRUANote_GrpNote_TxtNote().Click()
           WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
          Get_WinCRUANote_BtnSave().Click();
          
        
          //Les points de vérifications
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, modelTextAddNotCROES1259);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, modelTextAddNotCROES1259);
            var textNotCROES1259= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(modelTextAddNotCROES1259), 10)
            var x=textNotCROES1259.Exists;
            Log.Message(x);
          if(textNotCROES1259.Exists && textNotCROES1259.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")}
          
          
          
          
          
          Get_WinModelInfo_BtnOK().Click();
         //Vérification que la note est modifé aprés avoir fermer la fenêtre info
               SearchModelByName(modelNameCroes940);
         Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();
         Get_ModelsBar_BtnInfo().Click();
         Get_WinModelInfo_TabNotes().Click();
         Get_WinModelInfo_TabNotes_TabGrid().Click(); 
        //Les points de vérifications
        if(Get_WinInfo_Notes_TabGrid_DgvNotes_ChDeclareAsReview().Exists && Get_WinInfo_Notes_TabGrid_DgvNotes_ChDeclareAsReview().VisibleOnScreen )
            {
              Log.Error("la colonne review existe")
             } 
            else
            {
               Log.Checkpoint("la colonne review n'existe pas")
        
            }
         //Faire un right-click sur une colonne ensuite cliquer sur ajouter une colonne
        Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreatedBy().ClickR()
         Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
         
         // les points de vérifications
        if( Get_SubMenus().Find("WPFControlText","Review",10).Exists)
             {
               Log.Error("la colonne review existe")
             } 
            else
            {
               Log.Checkpoint("la colonne review n'existe pas")
        
            }

         
          Get_WinModelInfo_BtnOK().Click();
          
          //Fermer Croesus
          Log.Message("Fermer Croesus")
          Close_Croesus_X();     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Delete_Note(modelTextAddNotCROES1259, vServerModeles)         
		    Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","0",vServerModeles);
        RestartServices(vServerModeles);
      
      }  
}