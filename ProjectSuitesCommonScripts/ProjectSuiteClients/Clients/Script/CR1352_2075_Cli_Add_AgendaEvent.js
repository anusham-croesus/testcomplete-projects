//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : Modification permise dans info clients
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2075
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ //il faut finaliser le script 
 
 function CR1352_2075_Cli_Add_AgendaEvent()
 {    
// script spécifique pour BNC
      var rootClient="800075"
      var roots= GetData(filePath_Clients,"CR1352",202,language)   
    
      Login(vServerClients,userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
      
      //sélectionner le client
      Search_Client(rootClient);             
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient,10).DblClick(); 
        
      //Ajouter un evenement dans l'agenda
      Get_WinDetailedInfo_TabAgendaForClient().Click();  
      //Delay(1500);
      WaitObject(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation(),"Uid", "Button_7f1b", 10);
      Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnAdd().Click();
         
      Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule().Click();
      
      //Saisir une date   
      var month= aqConvert.VarToStr(aqConvert.DateTimeToFormatStr(aqDateTime.GetMonth(aqDateTime.Now()),"%m"))
      var day= aqConvert.VarToStr(aqConvert.DateTimeToFormatStr(aqDateTime.GetDay(aqDateTime.Now()),"%d")) 
      var year=aqConvert.StrToInt(aqDateTime.GetYear(aqDateTime.Now()))+1
      
      Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule().Click()
      
      if(language=="french"){
        Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule().set_StringValue(year+"/"+month+"/"+day)
      }
      else{
        Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule().set_StringValue(month+"/"+day+"/"+year)       
      }
      
      Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForSchedule().set_Text(GetData(filePath_Clients,"CR1352",227,language));       
      Get_WinAddEditAnEvent_BtnOKForSchedule().Click();      
      
      //Vérifier qu’évènement a été ajouté 
      aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().WPFObject("ListViewItem", "", 1).DataContext,"Type",cmpEqual,GetData(filePath_Clients,"CR1352",227,language));
      aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().WPFObject("ListViewItem", "", 1).DataContext,"Date",cmpEqual,(year+"/"+month+"/"+day));
      
      Get_WinDetailedInfo_BtnOK().Click();
      //sélectionner le client
      Search_Client(rootClient);             
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient,10).DblClick();
      //Ajouter un evenement dans l'agenda
      Get_WinDetailedInfo_TabAgendaForClient().Click();
      Get_WinDetailedInfo_TabAgendaForClient().WaitProperty("IsSelected", true, 30000)
      //Vérifier qu’évènement a été ajouté 
      aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().WPFObject("ListViewItem", "", 1).DataContext,"Type",cmpEqual,GetData(filePath_Clients,"CR1352",227,language));
      aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().WPFObject("ListViewItem", "", 1).DataContext,"Date",cmpEqual,(year+"/"+month+"/"+day));
      
      //Supprimer un évènement ajouté 
      if(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().WPFObject("ListViewItem", "", 1).DataContext.Date==(year+"/"+month+"/"+day)){
          Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().WPFObject("ListViewItem", "", 1).Click();
          Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete().Click();
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
          Get_WinDetailedInfo_BtnApply().Click();
          //Delay(1500);
          WaitObject(Get_WinDetailedInfo(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10);
          Get_WinDetailedInfo_BtnOK().Click();
      }    
       
      Get_MainWindow().SetFocus();

 }
 

function test()
{
  RestartServices(vServerClients)
}