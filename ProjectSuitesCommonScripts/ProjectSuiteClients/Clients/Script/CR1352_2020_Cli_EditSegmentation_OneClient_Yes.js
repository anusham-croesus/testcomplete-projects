//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description :Fonction Modifier la segmentation
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2020
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ 
 
 function CR1352_2020_Cli_EditSegmentation_OneClient_Yes()
 {             
      var segmentation="A";
      
      Login(vServerClients,userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
    
      Get_ClientsGrid_ChName().ClickR();
      Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
      
      Get_ClientsGrid_ChName().ClickR();
      Get_GridHeader_ContextualMenu_AddColumn().Click();
      Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find("WPFControlText","Field: SegmentationDisplay",10).Click()
          
      
      if (client == "BNC" ){     
        //Sélectionner 3 clients 
        for(var i=0; i <=2; i++){
              Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true)
              Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsActive(true)
             
        } 
      }
      else{//RJ
            //Sélectionner 3 clients 
        for(var i=3; i <=5; i++){
              Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true)
              Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsActive(true)
              
        } 
      }
      if (client == "BNC" ){
        var clientNumber= VarToStr(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(1).DataItem.get_ClientNumber());
      }
      else{//RJ
        var clientNumber= VarToStr(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(3).DataItem.get_ClientNumber());
      }
      
      Get_RelationshipsClientsAccountsGrid().FindChild("Value",clientNumber,10).ClickR();
      Get_RelationshipsClientsGrid_ContextualMenu_EditSegmentation().Click();
              
      var clientName = VarToStr(Get_WinEditSegmentation_GrpApplyOn_RdoActiveRelationshipOrClient().WPFControlText);
      Get_WinEditSegmentation_GrpApplyOn_RdoActiveRelationshipOrClient().set_IsChecked(true);
       
      //Modifier la segmentaion
      EditSegmentation(segmentation);
      
      aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients, "CR1352", 239, language));
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/4, Get_DlgConfirmation().get_ActualHeight()-45);
      
      //Vérifier les modifications 
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",clientName,10).DataContext.DataItem, "SegmentationDisplay",cmpEqual,segmentation)
      
      //Remettre les données 
      //Modifier le champ segmentation
      Get_RelationshipsClientsAccountsGrid().Find("Value",clientName,10).DblClick();
      Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation().set_Text("");  
      Get_WinDetailedInfo_BtnApply().Click();
      Delay(500)      
      Get_WinDetailedInfo_BtnOK().Click();
      
      //Vérifier les modifications 
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",clientName,10).DataContext.DataItem, "SegmentationDisplay",cmpEqual,"")
        
      Get_ClientsGrid_ChSegmentation().ClickR();
      Get_GridHeader_ContextualMenu_RemoveThisField().Click();
      
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();  
 }
 
 function EditSegmentation(segmentation)
{
    Get_WinEditSegmentation_CmbSegmentation().DropDown();
    Get_WinEditSegmentation_CmbSegmentation().set_Text(segmentation);
    Get_WinEditSegmentation_CmbSegmentation().CloseUp();
    Get_WinEditSegmentation_BtnOK().Click(); 
 }