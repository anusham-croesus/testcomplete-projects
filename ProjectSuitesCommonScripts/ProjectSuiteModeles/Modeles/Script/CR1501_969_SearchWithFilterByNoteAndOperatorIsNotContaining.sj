//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
            Préconditions :

           Se connecter avec 'COPERN'

        https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-969
        Description : 
        1-Choisir le module modèle.:Le module modèle s'ouvre correctement.
        2-Sélectionner un modèle:Le modèle est bien sélectionné.
        3-Cliquer sur le bouton 'Info':La fenêtre info est ouverte.
        4-Cliquer sur filtre et choisir le filtre 'Note':La liste des filtres s'ouvre correctement et la fenêtre 'Créer un filtre'  de 'Note' est ouverte.
        5-Choisir 'ne contenant pas' pour le champ 'Opérateur' ,saisir une valeur ensuite cliquer sur le bouton 'Appliquer':
        Les notes correspondant au filtre sont affichées.

         
        
    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-8--V9-Be_1-co6x
*/
function CR1501_969_SearchWithFilterByNoteAndOperatorIsNotContaining()
{
  try {
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-969");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
       var modelNameCroes940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes940", language+client);
       var modelTextAddNotCROES969=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES969", language+client);
       var descriptionFiltreNoteCROES969=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "descriptionFiltreNoteCROES969", language+client);
       var ContenantNoteCROES969=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "ContenantNoteCROES969", language+client);
       
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
         Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES969);
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
         Get_WinCRUANote_BtnSave().Click();
         
          //Les points de vérifications
          
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, modelTextAddNotCROES969);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, modelTextAddNotCROES969);
            var textNotCROES969= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(modelTextAddNotCROES969), 10)
            var x=textNotCROES969.Exists;
            Log.Message(x);
          if(textNotCROES969.Exists && textNotCROES969.VisibleOnScreen)
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
            Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_Note().Click()
            Get_WinCreateFilter_CmbOperator().Click()
            Get_WinCreateFilter_CmbOperator_ItemNotContaining().Click();
            Get_WinCreateFilter_TxtValue().Click();
            Get_WinCreateFilter_TxtValue().Keys(ContenantNoteCROES969);
            Get_WinCreateFilter_BtnApply().Click();
            
            
           //Les points de vérification 
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual,descriptionFiltreNoteCROES969);
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  */
       //Vérifier que la note qui contient le mot note est affichée
         var  ExistenceResultatFiltreOnGrill=Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",modelTextAddNotCROES969,10)
           if(ExistenceResultatFiltreOnGrill.Exists)
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
         Delete_Note(modelTextAddNotCROES969, vServerModeles)
        Terminate_CroesusProcess();
      }  
}
