//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions


/**
    Description : Gérer des notes de comptes
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1520
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1520_Acc_Manage_Accounts_notes()
{
    var accountNo = "800228-FS";
    var noteText1 = "Test Note 1";
    var noteText2 = "Test Note 2";
    
    try {
        
        Login(vServerAccounts, userName, psw, language);
        
        //Sélectionner un compte et faire double-clic
        
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(accountNo);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).DblClick();

        if (Get_WinDetailedInfo().Exists){
            aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Accounts, "CR1352", 101, language));
        }
        else {
            Log.Error("The 'Account Info' window was not displayed.");
            return;
        }
        
        //Ajouter une note puis cliquer sur OK
        
        Get_WinAccountInfo_TabNotes().Click();
        Get_WinInfo_Notes_TabGrid().Click();
        Get_WinInfo_Notes_TabGrid_BtnAdd().Click();

        if (Get_WinCRUANote().Exists){
            aqObject.CheckProperty(Get_WinCRUANote(), "Title", cmpEqual, GetData(filePath_Accounts, "CR1352", 102, language));
        }
        else {
            Log.Error("The 'Add a Note' window was not displayed.");
            return;
        }
        
        Get_WinCRUANote_GrpNote_TxtNote().Keys(noteText1);
        Get_WinCRUANote_BtnSave().Click();
        
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"WindowMetricTag","ACCOUNT_INFORMATION");
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).DblClick();

        
        Get_WinAccountInfo_TabNotes().Click();
        Get_WinInfo_Notes_TabGrid().Click();
    
        if (ClickOnNote(noteText1)){
            Log.Checkpoint("Note successfully added.");
        }
        else {
            Log.Error("Note not added");
            return;
        }     
        
        //Choisir modifier dans l'onglet note
             
        Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
        Get_WinCRUANote().WaitProperty("VisibleOnScreen", true, 20000);
        
        if (Get_WinCRUANote().Exists){
            aqObject.CheckProperty(Get_WinCRUANote(), "Title", cmpEqual, GetData(filePath_Accounts, "CR1352", 103, language));
        }
        else {
            Log.Message("Le numéro de l'anomalie sur CX :  CROES-7834");
            Log.Error("The 'Edit a Note' window was not displayed.");
            return;
        }
               
        //Changer le contenu et cliquer sur OK
        Delay(1000);
        Get_WinCRUANote_GrpNote_TxtNote().set_Text(noteText2);
        Get_WinCRUANote_BtnSave().Click();
        
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog", 1]);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).DblClick();
        
        Get_WinAccountInfo_TabNotes().Click();
        Get_WinInfo_Notes_TabGrid().Click();
        
        if (ClickOnNote(noteText2)){
            Log.Checkpoint("Note successfully edited.");
        }
        else {
            Log.Error("Note not edited.");
            return;
        }
        
        
        //Supprimer la note
        
        Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
        Log.Message("CROES-6167: Demande de comfirmation avant la suppression de la note.")
         if(Get_DlgConfirmation().Exists){  //EM : Modifié selon CROES-6167 
             var width = Get_DlgConfirmation().Get_Width();//SA : modifier suite a CO la fenêtre est devenue fenêtre de confirmation au lieu d'information
            Get_DlgConfirmation().Click((width)*(1/3),63); //SA : modifier suite a CO la fenêtre est devenue fenêtre de confirmation au lieu d'information       
         }
        //Delay(100);
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog", 1]);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).DblClick();

        
        Get_WinAccountInfo_TabNotes().Click();
        Get_WinInfo_Notes_TabGrid().Click();
        
        if (!ClickOnNote(noteText2)){
            Log.Checkpoint("Note successfully deleted.");
        }
        else {
            Log.Message("CROES-10024");
            Log.Error("Note not deleted.");
        }
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
            
        //Fermer Croesus
        Terminate_CroesusProcess();
        
        //Purger toutes les notes du compte
        Log.Message("Delete all notes of account " + accountNo + " ...");
        Login(vServerAccounts, userName, psw, language);
    
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(accountNo);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).DblClick();
        Get_WinAccountInfo_TabNotes().Click();
        Get_WinInfo_Notes_TabGrid().Click();
        
        var notesCount = Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Count;
        if(client == "TD" ){
           if (ClickOnNote(noteText1)){
          Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
            Get_WinInfo_Notes_TabGrid_BtnDelete().WaitProperty("IsEnabled", false, 5000);}
           if (ClickOnNote(noteText2)){
           Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
           Get_WinInfo_Notes_TabGrid_BtnDelete().WaitProperty("IsEnabled", false, 5000);}
           
        } 
        else{
        for (var i = notesCount; i > 0; i--){
          //Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("DragableListViewItem", "", i).Click();
            Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).Click();
            Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
            if(Get_DlgInformation().Exists){  //EM : Modifié selon CROES-6167 
            var width = Get_DlgInformation().Get_Width();
            Get_DlgInformation().Click((width*(1/2)),73);         
         }
            Get_WinInfo_Notes_TabGrid_BtnDelete().WaitProperty("IsEnabled", false, 5000);
        }}
    
        Get_WinDetailedInfo_BtnOK().Click();
    
        Terminate_CroesusProcess();
    }
    

}




function ClickOnNote(noteText)
{
    var notesCount = Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Count;
    var isFound = false;
    for (var i = 0; i < notesCount; i++){
        if (Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Comment == noteText){//YR 90-04-44  .Items.Item(i).Item(1).data
            isFound = true;
            Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (i+1)).Click();//DragableListViewItem dans 90-04-32
            break;
        }
    }
    
    if (isFound){
        Log.Message("Note '" + noteText + "' found.");
        return true;
    }
    else {
        Log.Message("Note '" + noteText + "' not found.");
        return false;
    }

}
