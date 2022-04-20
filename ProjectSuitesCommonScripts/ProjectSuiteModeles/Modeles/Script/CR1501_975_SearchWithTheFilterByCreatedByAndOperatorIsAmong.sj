//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
            Préconditions :

           Se connecter avec 'COPERN'

       https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-975
        Description : 
        1-Choisir le module modèle.:Le module modèle s'ouvre correctement.
        2-Sélectionner un modèle:Le modèle est bien sélectionné.
        3-Cliquer sur le bouton 'Info':La fenêtre info est ouverte.
        4-Cliquer sur filtre et choisir le filtre 'Créée par':La liste des filtres s'ouvre correctement
         et la fenêtre 'Créer un filtre'  de 'Créée par' est ouverte.
        5-Choisir 'parmi' pour le champ 'Opérateur' ,choisir une valeur ensuite cliquer sur le bouton 'Appliquer':
          Les notes correspondant au filtre sont affichées.

         
        
    Auteur : Sana Ayaz
    Version de scriptage:ref90-08-Dy-8--V9-Be_1-co6x
*/
function CR1501_975_SearchWithTheFilterByCreatedByAndOperatorIsAmong()
{
  try {
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-975");
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
       var modelNameCroes940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes940", language+client);
       var modelTextAddNotCROES975=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES975", language+client);
       var descriptionFiltreNoteCROES975=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "descriptionFiltreNoteCROES975", language+client);
       var UserCopernCROES975=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "UserCopernCROES975", language+client);
       
       
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
         Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES975);
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
         Get_WinCRUANote_BtnSave().Click();
         
          //Les points de vérifications
          
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, modelTextAddNotCROES975);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, modelTextAddNotCROES975);
            var textNotCROES975= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(modelTextAddNotCROES975), 10)
            var x=textNotCROES975.Exists;
            Log.Message(x);
          if(textNotCROES975.Exists && textNotCROES975.VisibleOnScreen)
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
            Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_CreatedBy().Click()
            Get_WinCreateFilter_CmbOperator().Click()
            WaitObject(Get_Models_Details(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);
            Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
            Select_UserCreerFiltre(UserCopernCROES975)
           
            Get_WinCreateFilter_BtnApply().Click();
            
            
           //Les points de vérification 
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual,descriptionFiltreNoteCROES975);
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  */
       //Vérifier que la note qui contient le mot note est affichée
         var  ExistenceResultatFiltreOnGrill=Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",UserCopernCROES975,10)
           if(ExistenceResultatFiltreOnGrill.Exists)
              {
                  Log.Checkpoint("Le résultat du filtre est correct")
                }
                else
                {
                 Log.Error("Le résultat du filtre n'est pascorrect") 
                } 
       
       
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
         Delete_Note(modelTextAddNotCROES975, vServerModeles)
        Terminate_CroesusProcess();
      }  
}
function Select_UserCreerFiltre(nameUserCreatFiltre)
{
  
  
    var GrillCreatFiltreCount = Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.get_Count();
    Get_WinCreateFilter_DgvValue().Keys("[Home]");
    for (var i = 1; i < GrillCreatFiltreCount; i++){
        var currentuserName = VarToStr(Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Value.OleValue);
        
        if (currentuserName == nameUserCreatFiltre){
            Get_WinCreateFilter_DgvValue().Find("Value",currentuserName,10).Click();
            
            break;
        }

        Get_WinCreateFilter_DgvValue().Keys("[Down]");
        Get_WinCreateFilter_DgvValue().Find("Value",currentuserName,10).Click();
    }
   
   
   

}
