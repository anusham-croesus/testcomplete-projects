//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
            Préconditions :

           Se connecter avec 'COPERN'

       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-953
        Description : 
        1-Choisir le module modèle.:Le module modèle s'ouvre correctement.
        2-Sélectionner un modèle:Le modèle est bien sélectionné.
        3-Cliquer sur le bouton 'Info':La fenêtre info est ouverte.
        4-Cliquer sur filtre et choisir le filtre 'date de création':La liste des filtres s'ouvre correctement
         et la fenêtre 'Créer un filtre'  de 'Date de création' est ouverte.
        5-Cliquer sur filtre et choisir le filtre 'date de création': La liste des filtres s'ouvre correctement
         et la fenêtre 'Créer un filtre'  de 'Date de création' est ouverte.
         6-Choisir 'n'égal(e) pas' pour le champ 'Opérateur' ,saisir une valeur ensuite cliquer sur le bouton 'Appliquer':Les notes correspondant
          au filtre sont affichées.
         
        
    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-8--V9-Be_1-co6x
*/
function CR1501_953_ValidationOfTheSearchWithTheFilterByDateCreationAndOperatorIsNotEqual()
{
  try {
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-953");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
       var modelNameCroes940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes940", language+client);
       var modelTextAddNotCROES953=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES953", language+client);
       var descriptionFiltreCreatioDateCROES953=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "descriptionFiltreCreatioDateCROES953", language+client);
       
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        //Chercher un modéle
         SearchModelByName(modelNameCroes940);
         Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();
         Get_ModelsBar_BtnInfo().Click();
         Get_WinModelInfo_TabNotes().Click();
         Get_WinModelInfo_TabNotes_TabGrid().Click();
         Get_WinModelInfo_TabNotes_TabGrid_BtnAdd().Click();
         WaitObject(Get_CroesusApp(), "Uid", " NoteDetailWindow_2d5e");
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES953);
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
         Get_WinCRUANote_BtnSave().Click();
         
          //Les points de vérifications
         
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, modelTextAddNotCROES953);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, modelTextAddNotCROES953);
            var textNotCROES953= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(modelTextAddNotCROES953), 10)
            var x=textNotCROES953.Exists;
            Log.Message(x);
          if(textNotCROES953.Exists && textNotCROES953.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
          
          }

          Get_WinModelInfo_BtnOK().Click();
          SearchModelByName(modelNameCroes940);
          Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();
          Get_ModelsBar_BtnInfo().Click();
          Get_WinModelInfo_TabNotes().Click();
          Get_WinModelInfo_TabNotes_TabGrid().Click();
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
            var displayFiltrecreation=aqString.Concat(descriptionFiltreCreatioDateCROES953, ToDay)
            
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
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
         Delete_Note(modelTextAddNotCROES953, vServerModeles)
        Terminate_CroesusProcess();
      }  
}
