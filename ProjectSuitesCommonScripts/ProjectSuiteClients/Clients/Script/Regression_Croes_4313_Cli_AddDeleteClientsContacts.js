//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4313
    
   
    Description :Ajouter/supprimer les Contacts pour Client.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-10--V9-croesus-co7x-1_5_1_572
    
    Date: 19/04/2019
*/

function Regression_Croes_4313_Cli_AddDeleteClientsContacts()
{
  try{
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4313", "Croes-4313");
        var nbEntreesInitialAgenda = 0;
        var clientNum800228=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNum1_4313", language+client);
        var TypeDejeuner=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "EventLunch", language+client);
        var TypeRDV=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "EventAppointment", language+client); 
        var etatEvent = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "status", language+client);
        var copierInfoClient = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "InfoClientCopy", language+client);
    
        //***********************Ajouté par A.A
        var copierInfoClient = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "InfoClientCopy", language+client);
        var clientNum800240 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNum2_4313", language+client);
        //var eventDate = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "EventDate_4313", language+client);
      
        //Accès au module client
        Login(vServerClients, userName,psw,language);
        Get_ModulesBar_BtnClients().Click();    
        Get_MainWindow().Maximize();
    
        //Sélectionner le client 800228 et ouvrir Info  
        Search_Client(clientNum800228);
        Get_ClientsBar_BtnInfo().Click();
    
        //Sélectionner Agenda et cliquer sur Ajouter
        Get_WinDetailedInfo_TabAgendaForClient().Click();
        WaitObject(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation(),"Uid", "Button_7f1b", 10);
        //Ajouter le type "Déjeuner"
        nbEntreesInitialAgenda = Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().Items.Count;
        Log.Message("Nombre entrées initial dans Agenda = " +nbEntreesInitialAgenda);
        Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnAdd().Click();   
        Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForSchedule().Click();
        Get_SubMenus().FindChild("WPFControlText", TypeDejeuner, 10).Click();
        Get_WinAddEditAnEvent_BtnOKForSchedule().Click();
    
        //Valider l'ajout de l'événement "Déjeuner" dans la fenêtre Agenda
        ValiderAjoutEvenement(TypeDejeuner, nbEntreesInitialAgenda);
        //aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().WPFObject("ListViewItem", "", 1).DataContext,"Type",cmpEqual,TypeDejeuner)
        //aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", TypeDejeuner, 10),"Exists",cmpEqual,true)
        //aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", TypeDejeuner, 10),"VisibleOnScreen",cmpEqual,true)
    
        //Ajouter le type "Rendez-Vous "
        nbEntreesInitialAgenda = Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().Items.Count;
        Log.Message("Nombre entrées initial dans Agenda = " +nbEntreesInitialAgenda);
        Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnAdd().Click();
        WaitObject(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation(),"Uid", "Button_7f1b", 10);
        Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForSchedule().Click();
        Get_SubMenus().FindChild("WPFControlText", TypeRDV, 10).Click();
        Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbStatusForSchedule().Click();
        Get_SubMenus().FindChild("WPFControlText", etatEvent, 10).Click();
        Get_WinAddEditAnEvent_BtnOKForSchedule().Click();
    
    
        //Valider l'ajout de l'événement "Rendez-Vous" dans la fenêtre Agenda
        ValiderAjoutEvenement(TypeRDV, nbEntreesInitialAgenda);
        //aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().WPFObject("ListViewItem", "", 1).DataContext,"Type",cmpEqual,TypeRDV)
        //aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", TypeRDV, 10),"Exists",cmpEqual,true)
        //aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", TypeRDV, 10),"VisibleOnScreen",cmpEqual,true)
    
        //Supprimer l'événement "Déjeuner" et valider la suppression
        Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", TypeDejeuner, 10).Click();
        Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete().Click();
        Get_DlgConfirmation_BtnYes().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", TypeDejeuner, 10),"Exists",cmpEqual,false)

        if(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", TypeDejeuner, 10).Exists && Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", TypeDejeuner, 10).VisibleOnScreen)
         Log.Error("L'événement Déjeuner n'est pas supprimé")       
        else
         Log.Checkpoint("L'événement Déjeuner est supprimé")

        /* MODIFIÉ PAR A A.
        //Rétablir la configuration par défaut (supprimer l'événement "Rendez-Vous" )  
        Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", TypeRDV, 10).Click();
        Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete().Click();
        Get_DlgConfirmation_BtnYes().Click();
        */

        Get_WinDetailedInfo_BtnApply().Click();
        WaitObject(Get_WinDetailedInfo(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10);
        Get_WinDetailedInfo_BtnOK().Click();
     
        /***************************************************Étapes ajoutées par Amine A. ***********************************************/
           
        Search_Client(clientNum800228);
      
        //Faire Clique droit et cliquer sur 'Copier info client'
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum800228, 10).ClickR();
        Get_SubMenus().FindChild("WPFControlText", copierInfoClient, 10).Click();
      
        Log.Message("**********************Ouvrir la fenêtre 'Copier les infos'");
        Get_WinCopyClientInfo_ListPickerCombo().Click();
        Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBoxItem", "2"], 10).Click();
        Get_WinCopyClientInfo_TxtQuickSearch().SetText(clientNum800240);
        WaitObject(Get_WinCopyClientInfo(), "Uid", "ListPickerExec_9344", 3000);
        Get_WinCopyClientInfo_ListPicker().WaitProperty("IsEnabled",true,3000);
        Get_WinCopyClientInfo_ListPicker().Click();
        Get_WinCopyClientInfo_ListPicker().Click();
        Get_WinCopyClientInfo_ChkBoxAgenda().Click();
        Get_WinCopyClientInfo_BtnOK().Click();
      
        Log.Message("*****************Ouvrir la fenêtre Info Tab Agenda");   
        Get_ClientsBar_BtnInfo().Click();
        //Sélectionner Agenda et cliquer sur Ajouter
        Get_WinDetailedInfo_TabAgendaForClient().Click();  
        WaitObject(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation(),"Uid", "Button_7f1b", 10);

        var toDay = aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d")
        Log.Message("Today is " + toDay);
        Log.Message("**********************Vérifier que l'évenement est ajouté dans l'Agenda");
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", toDay, 10),"Exists",cmpEqual,true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", toDay, 10),"VisibleOnScreen",cmpEqual,true);
    
        //Supprimer l'évenement ajouté de l'agenda
        Log.Message("********************** supprimer l'évenement et fermer Info");
        Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", toDay, 10).Click();
        WaitObject(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation(),"Uid", "Button_f83f", 10);
        Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete().Click();
        WaitObject(Get_DlgConfirmation(),"Uid", "PART_Yes", 10);
        Get_DlgConfirmation_BtnYes().Click();
        Get_WinDetailedInfo_BtnOK().Click();
      
        //Enlever le filtre
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); 
           
        //Sélectionner le client 800228 et ouvrir Info  
        Search_Client(clientNum800228);
        Get_ClientsBar_BtnInfo().Click();
    
        //Sélectionner Agenda 
        Get_WinDetailedInfo_TabAgendaForClient().Click();  
        WaitObject(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation(),"Uid", "Button_7f1b", 10);   
     
        // supprimer évenement de l'Agenda du client 800228 
        Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", toDay, 10).Click();
        WaitObject(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation(),"Uid", "Button_f83f", 10);
        Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete().Click();
        WaitObject(Get_DlgConfirmation(),"Uid", "PART_Yes", 10);
        Get_DlgConfirmation_BtnYes().Click();
        Get_WinDetailedInfo_BtnOK().Click();
  }
  catch(e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();    
  }   
}

function ValiderAjoutEvenement(typeEvenement, nbEntreesOrigine)
{
    var nbMaxValideEntree = 5
    var nbEntreesAgenda = 0;
    var count = 0;
    
    do{
        count = count+1;
        nbEntreesAgenda = Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().Items.Count;
        Log.Message("Nombre d'entrées dans Agenda = " +nbEntreesAgenda);
        if (count > nbMaxValideEntree)
            Log.Warning("Le nombre d'essais pour vérifier l'augmentation d'entrées dans Agenda dépasse le maximum de " +nbMaxValideEntree +".");
    } while (nbEntreesAgenda <= nbEntreesOrigine && count <= nbMaxValideEntree);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().WPFObject("ListViewItem", "", 1).DataContext,"Type",cmpEqual,typeEvenement)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", typeEvenement, 10),"Exists",cmpEqual,true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild("WPFControlText", typeEvenement, 10),"VisibleOnScreen",cmpEqual,true)
}