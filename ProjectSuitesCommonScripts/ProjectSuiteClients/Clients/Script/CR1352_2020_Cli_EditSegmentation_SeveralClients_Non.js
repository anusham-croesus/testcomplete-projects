//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_2020_Cli_EditSegmentation_OneClient_Yes
//USEUNIT Global_variables

/* Description :Fonction Modifier la segmentation
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2020
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ 
 
 function CR1352_2020_Cli_EditSegmentation_SeveralClients_Non()
 {             
      var segmentation="B";
      var clientNumber=new Array(); //utilisé pour stocker des numéros des clients
      var clientSegmentation=new Array(); //utilisé pour stocker des segmentations
      
      Login(vServerClients,userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
    
      Get_ClientsGrid_ChName().ClickR();
      Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
      
      Get_ClientsGrid_ChName().ClickR();
      Get_GridHeader_ContextualMenu_AddColumn().Click();
      Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find("WPFControlText","Field: SegmentationDisplay",10).Click()
            
      //Sélectionner 3 clients. Stocker des numéros des clients sélectionnés et leurs segmentations 
      for(var i=0; i <=2; i++){
            Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true)
            Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsActive(true)            
            clientNumber[i]=VarToStr(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).DataItem.get_ClientNumber());
            clientSegmentation[i]=VarToStr(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).DataItem.get_SegmentationDisplay())
            Log.Message(clientNumber[i])           
      } 
            
      var firstClientNumber= VarToStr(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(0).DataItem.get_ClientNumber());
      Get_RelationshipsClientsAccountsGrid().FindChild("Value",firstClientNumber,10).ClickR();
      Get_RelationshipsClientsGrid_ContextualMenu_EditSegmentation().Click();
              
      Get_WinEditSegmentation_GrpApplyOn_RdoSelectedRelationshipsOrClients().set_IsChecked(true);
       
      //Modifier la segmentaion
      EditSegmentation(segmentation);
      
      //Cliquer sur Non
      aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients, "CR1352", 239, language));
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(3/4)-15, Get_DlgConfirmation().get_ActualHeight()-45);
      Get_WinEditSegmentation_BtnCancel().Click(); 
      
      //Vérifier que les données n’ont pas été modifiées.La validation a été faite contre les données stockes dans des Arrays     
       for(var i=0; i <=2; i++){
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",clientNumber[i],10).DataContext.DataItem, "SegmentationDisplay",cmpEqual,clientSegmentation[i])
      }
                   
      Get_ClientsGrid_ChSegmentation().ClickR();
      Get_GridHeader_ContextualMenu_RemoveThisField().Click();
      
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();  
 }