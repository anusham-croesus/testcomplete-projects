//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                    1. Se connecter avec ROOSEF
                    2. Aller au module Client
                    3. Ajouter une note ou modifier une note 
                    
      Résultat reçu 
      Les colonnes "Date de référence" et "date de modification" ne sont plus disponibles 



    Auteur : Sana Ayaz
    Anomalie:CROES-9031
    Version de scriptage:ref90-04-BNC-59B-11
*/
function CROES_9031_ComMissingColumnsInTheNotesGrid()
{
    try {
        
        
        userNameROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username");
        passwordROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw");
        //Se connecter avec ROOSEF
        Login(vServerAccounts, userNameROOSEF, passwordROOSEF, language);
        var NumberAccount800285FS=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "NumberAccount800285FS", language+client);
        var TextNotCROES_9031=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "TextNotCROES_9031", language+client);
        var TextNotCROES_9031Modif=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "TextNotCROES_9031Modif", language+client);
        Get_ModulesBar_BtnAccounts().Click();
        //Ajouter une note ou modifier une note 
        Search_Account(NumberAccount800285FS)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumberAccount800285FS, 10).Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumberAccount800285FS, 10).DblClick();
        Get_WinDetailedInfo().WaitProperty("VisibleOnScreen", true, 500)
        Get_WinInfo_Notes_TabGrid().Click();
        //Ajouter une note
        Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
        Get_WinCRUANote_GrpNote_TxtNote().set_Text(TextNotCROES_9031)
        Get_WinCRUANote_GrpNote_TxtNote().Click();
        Get_WinCRUANote_BtnSave().Click();
        // Les points de vérifications: Les colonnes "Date de référence" et ""date de modification'' sont plus disponibles 
        
        if(Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().Exists)
        {
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate(), "VisibleOnScreen", cmpEqual, true);
        }
       else Log.Error("La colonne Date de création n'existe pas")
       
        if(Get_WinInfo_Notes_TabGrid_DgvNotes_ChEffectiveDate().Exists)
        {
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChEffectiveDate(), "VisibleOnScreen", cmpEqual, true);
        }
       else Log.Error("La colonne Date de référence n'existe pas")

       
       // Vérifier que si on modifie la note créer précédemment on voit les deux colonnes : "Date de référence" et ""date de modification'
       Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", TextNotCROES_9031, 10).Click();
       Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
       Get_WinCRUANote().WaitProperty("VisibleOnScreen", true, 20000);
       Get_WinCRUANote_GrpNote_TxtNote().set_Text(TextNotCROES_9031Modif)
        Get_WinCRUANote_GrpNote_TxtNote().Click();
        Get_WinCRUANote_BtnSave().Click();
         // Les points de vérifications: Les colonnes "Date de référence" et ""date de modification'' sont plus disponibles 
        
        if(Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().Exists)
        {
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate(), "VisibleOnScreen", cmpEqual, true);
        }
       else Log.Error("La colonne Date de création n'existe pas")
       
        if(Get_WinInfo_Notes_TabGrid_DgvNotes_ChEffectiveDate().Exists)
        {
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChEffectiveDate(), "VisibleOnScreen", cmpEqual, true);
        }
       else Log.Error("La colonne Date de référence n'existe pas") 
       Get_WinDetailedInfo_BtnCancel().Click();
      
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerAccounts, userNameROOSEF, passwordROOSEF, language);

    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerAccounts, userNameROOSEF, passwordROOSEF, language);
        Get_ModulesBar_BtnAccounts().Click();
        //Ajouter une note ou modifier une note 
         Search_Account(NumberAccount800285FS)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumberAccount800285FS, 10).Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumberAccount800285FS, 10).DblClick();
         Get_WinDetailedInfo().WaitProperty("VisibleOnScreen", true, 500)
        Get_WinInfo_Notes_TabGrid().Click();
        Get_WinInfo_Notes_TabGrid().WaitProperty("IsSelected", true, 30000)
        
        var NotdispalyMOD=Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",TextNotCROES_9031Modif,100)
        if(NotdispalyMOD.Exists )
        {
          Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",TextNotCROES_9031Modif,100).Click()
          Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
          if(Get_DlgConfirmation().Exists){
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),63);  
          }
        var Notdispaly=Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",TextNotCROES_9031,100)
        
         if(Notdispaly.Exists )
        {
          Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",TextNotCROES_9031,100).Click()
          Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
          if(Get_DlgConfirmation().Exists){
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),63);         
          }

        }
        Get_WinDetailedInfo_BtnOK().Click();
        
        Terminate_CroesusProcess(); 
        
        
        }
    }

}