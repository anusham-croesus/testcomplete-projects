//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Résumé : Correspond au jira CROES-10768 Date de référence vide lorsqu'une note est appliqué pour une ou plusieurs positions en même temps.
    
    Lien sur TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6808
    Lien sur Jira : https://jira.croesus.com/browse/CROES-10768
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Abdel Matmat
    
    Version de scriptage:	90.12.Hf-12
*/

function CROES_6808_Jira_CROES_10768_ReferenceDateReportedInNote()
{
    try {
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6808");
        Log.Link("https://jira.croesus.com/browse/CROES-10768"); 
        
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "client300001", language+client);        
        var noteCROES6808 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "noteCROES6808", language+client);
        var dateReferenceCROES6808 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "dateReferenceCROES6808", language+client);           
        var dateReferenceFormattedCROES6808 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "dateReferenceFormattedCROES6808", language+client);           
        var symbol1CROES6808 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "symbol1CROES6808", language+client);           
        var symbol2CROES6808 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "symbol2CROES6808", language+client);           
        
        //Login
        Log.Message("************************************** Login *********************************************")
        Login(vServerPortefeuille, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 15000);
        
        //Sélectionner le client 300001.
        var clientSelection= new Array(client300001);
        SelectClients(clientSelection);
        
        // Mailler vers portefeuille
        Log.Message("-------- Mailler le client sélectionné vers portefeuille--------------------");
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().OpenMenu();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        
        //Sélectionner les deux premières positions
        Log.Message("-------- Sélectionner les deux 902) premières positions -------------");
        Get_Portfolio_PositionsGrid().Find("Value",symbol1CROES6808,10).Click();
        Sys.Desktop.KeyDown(0x11);
        Get_Portfolio_PositionsGrid().Find("Value",symbol2CROES6808,10).Click();
        Sys.Desktop.KeyUp(0x11);
        
        //Ajouter une note
        Log.Message("--------- Ajouter une note ---------------------");
        Get_Portfolio_PositionsGrid().Find("Value",symbol2CROES6808,10).ClickR();
        Get_PortfolioGrid_ContextualMenu_AddANote().Click();
        WaitObject(Get_CroesusApp(),"Uid","NoteDetailWindow_2d5e");
        Log.Message("------- Saisir le texte de la note ---------------");
        Get_WinCRUANote_GrpNote_TxtNote().Keys(noteCROES6808)
        Log.Message("--------- Saisir la date effective ----------------")         ;
        Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity().Click();
        Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity().Keys(dateReferenceCROES6808)
        Get_WinCRUANote_BtnSave().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","NoteDetailWindow_2d5e");
        
        //Accéder à la fenêtre info d'une des deux positions
        Log.Message("--------------- Accéder à la fenêtre info d'une des deux positions --------------------");
        Get_Portfolio_PositionsGrid().Find("Value",symbol1CROES6808,10).DblClick();
        WaitObject(Get_CroesusApp(),"Uid","PositionInfo_75ee");
        Log.Message("---------------- Accéder à l'onglet Note ----------");
        Get_WinPositionInfo_TabNotes().Click();
   
        //Point de vérification
        Log.Message("------- Valider que la date de référence affichée est bien " +dateReferenceFormattedCROES6808+" -----------------");
        aqObject.CheckProperty(Get_WinPositionInfo().Find(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl",1],10).Items.Item(0).DataItem, "EffectiveDate", cmpEqual, dateReferenceFormattedCROES6808);
        
       
    }
    catch(e) {
      
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //supprimer la note créée
        Log.Message("------- Supprimer la note créée pour "+symbol1CROES6808+" --------------");
        Get_WinPositionInfo().Find(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl",1],10).Find("Value",noteCROES6808,10).Click();
        Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
        Get_DlgConfirmation_BtnDelete().Click();
        Get_WinPositionInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","PositionInfo_75ee");
        
        Get_Portfolio_PositionsGrid().Find("Value",symbol2CROES6808,10).DblClick();
        WaitObject(Get_CroesusApp(),"Uid","PositionInfo_75ee");
        Log.Message("---------------- Accéder à l'onglet Note ----------");
        Get_WinPositionInfo_TabNotes().Click();
        Log.Message("------- Supprimer la note créée pour "+symbol2CROES6808+" --------------");
        Get_WinPositionInfo().Find(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl",1],10).Find("Value",noteCROES6808,10).Click();
        Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
        Get_DlgConfirmation_BtnDelete().Click();
        Get_WinPositionInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","PositionInfo_75ee");
		    
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Terminate_IEProcess();  
        
        
    }
}
function test(){
  var noteCROES6808 = "Add note QA"
        Log.Message("------- Supprimer la note créée --------------");
        Get_WinPositionInfo().Find(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl",1],10).Find("Value",noteCROES6808,10).Click();
        Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
        Get_DlgConfirmation_BtnDelete().Click();
        Get_WinPositionInfo_BtnOK().Click();
        
        
         Get_Portfolio_PositionsGrid().Find("Value",symbol2CROES6808,10).DblClick();
        WaitObject(Get_CroesusApp(),"Uid","PositionInfo_75ee");
        Log.Message("---------------- Accéder à l'onglet Note ----------");
        Get_WinPositionInfo_TabNotes().Click();
        Log.Message("------- Supprimer la note créée pour "+symbol2CROES6808+" --------------");
        Get_WinPositionInfo().Find(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl",1],10).Find("Value",noteCROES6808,10).Click();
        Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
        Get_DlgConfirmation_BtnDelete().Click();
        Get_WinPositionInfo_BtnOK().Click();
}