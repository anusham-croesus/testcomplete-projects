//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description :Valider les informations de la racine secondaire dans la section détails
Pour valider l’affichage de données dans la patrie Détail, la fenêtre Info a été utilisée comme la référence. 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2054
  
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ 
 
 function CR1352_2054_Cli_DetailSection_Information_SecondaryRootClient()
 {    
//script spécifique a BNC
   
      var rootClient="800077";
      var rootClient1="800228";      
      var roots= GetData(filePath_Clients,"CR1352",202,language);   
      
      Login(vServerClients,userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
      
      //sélectionner le client
      Search_Client(rootClient);
      
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient,10).DblClick();
            
      //Les donnes de la fenêtre Info sont utilisés comme la référence pour valider les données dans la partie détail. 
      //Tab Info
      Get_WinDetailedInfo_TabInfo().Click();  
      Get_WinDetailedInfo_TabInfo().WaitProperty("IsSelected", true, 30000);
      var clientName = Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Text
      
      Get_WinDetailedInfo_TabAddresses().Click(); 
      Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
      var street1 = Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet1().Text
      var street2 = Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2().Text
      var postalCode = Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtPostalCode().Text
      
      //Tab Documents
      var docName=new Array(); // utilisé pour stocker les noms de documents 
      var docDate=new Array(); // utilisé pour stocker les dates de documents 
      
      Get_WinDetailedInfo_TabDocuments().Click(); 
      Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
      var docCount = (Get_PersonalDocuments_LstDocuments().ChildCount)-1  

       for(var i=1;i<=docCount;i++){
        docName[i]=Get_PersonalDocuments_LstDocuments().Items.Item(i).Metadata.Filename
        docDate[i]=Get_PersonalDocuments_LstDocuments().Items.Item(i).Metadata.Created
      } 
      
      //Tab Profil
      var profilName =new Array(); // utilisé pour stocker les noms de profils 
          
      Get_WinDetailedInfo_TabProfile().Click(); 
      Get_WinDetailedInfo_TabProfile().WaitProperty("IsSelected", true, 30000);
      var profilCount=Get_WinInfo_TabProfile_ItemControl().ChildCount
  
      for(var i=0;i<=(profilCount-1);i++){
        profilName[i]=Get_WinInfo_TabProfile_ItemControl().Items.Item(i).Description
      }      
      Get_WinDetailedInfo_BtnOK().Click();
      
      //Tab Produits&Services 
      Log.Message("Karima doit valider s’il y a une anomalie dans l'onglet Produits&Services ")
      

      
      //*********************************************Validation de données dans la  partie détail***************************************************************** 
      //*******************************************************************Tab Info*******************************************************************************
      
      //Dans la section détails, positionner le curseur sur le client racine secondaire
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient,10).Click();
      
      Get_ClientsDetails_TabInfo().Click();
      Get_ClientsDetails_TabInfo().WaitProperty("IsSelected", true, 30000);
      aqObject.CheckProperty(Get_ClientsDetails_TabInfo_InfoPage_TxtClientFullName(),"Text",cmpEqual,clientName);
      aqObject.CheckProperty(Get_ClientsDetails_TabInfo_InfoPage_TxtStreet1(),"Text",cmpEqual,street1);
      aqObject.CheckProperty(Get_ClientsDetails_TabInfo_InfoPage_TxtStreet2(),"Text",cmpEqual,street2);
      aqObject.CheckProperty(Get_ClientsDetails_TabInfo_InfoPage_TxtPostalCode(),"Text",cmpEqual,postalCode);
           
      //Dans la section détails, positionner le curseur sur le client principal
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient,10).Click();
      
      aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_TxtBalance(),"Text",cmpEqual,GetData(filePath_Clients,"CR1352",266,language));
      aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_TxtTotalValue(),"Text",cmpEqual,GetData(filePath_Clients,"CR1352",267,language));
      
      //Valider qu’on ne peut pas modifier les données 
      aqObject.CheckProperty(Get_ClientsDetails_TabInfo_InfoPage_TxtClientFullName(),"IsReadOnly",cmpEqual,true);
      aqObject.CheckProperty(Get_ClientsDetails_TabInfo_InfoPage_TxtStreet1(),"IsReadOnly",cmpEqual,true);
      aqObject.CheckProperty(Get_ClientsDetails_TabInfo_InfoPage_TxtStreet2(),"IsReadOnly",cmpEqual,true);
      aqObject.CheckProperty(Get_ClientsDetails_TabInfo_InfoPage_TxtPostalCode(),"IsReadOnly",cmpEqual,true);
      
      aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_TxtTotalValue(),"IsReadOnly",cmpEqual,true);
      aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_TxtBalance(),"IsReadOnly",cmpEqual,true);
      
      //******************************************************************Tab Profile****************************************************************************
      Get_ClientsDetails_TabProfile().Click();
      Get_ClientsDetails_TabProfile().WaitProperty("IsSelected", true, 30000);
      if(Get_ClientsDetails_TabProfile_ItemControl().ChildCount==profilCount){
       for (var i=0; i<=(profilCount-1);i++){
          aqObject.CheckProperty(Get_ClientsDetails_TabProfile_ItemControl().Items.Item(i),"Description",cmpEqual,VarToStr(profilName[i]))
       }
      }
      else{
        Log.Error("Le nombre de profiles est erroné")
      }
      
      //***************************************************************Tab Docoments*****************************************************************************
      Get_ClientsDetails_TabDocuments().Click();
      Get_ClientsDetails_TabDocuments().WaitProperty("IsSelected", true, 30000);
      //A partir de la version AT Les document ont été supprimés par Karima.
//      if((Get_ClientsDetails_TabDocuments_TpDocuments_LstDocuments().ChildCount -1)==docCount){
//        for(i=1;i<=docCount;i++){
//          aqObject.CheckProperty(Get_ClientsDetails_TabDocuments_TpDocuments_LstDocuments().Items.Item(i).Metadata,"Filename",cmpEqual,VarToStr(docName[i]))
//          aqObject.CheckProperty(Get_ClientsDetails_TabDocuments_TpDocuments_LstDocuments().Items.Item(i).Metadata,"Created",cmpEqual,docDate[i])
//        }
//      }
//      else{
//        Log.Error("Le nombre de documents est erroné")
//      }
       
       //Tab Produits&Services 
      Log.Message("Karima doit valider s’il y a une anomalie dans l'onglet Produits&Services")
      
      
      //********************************Pour vérifier les données d’onglet Agenda, le client 800228 a été utilisé*************************************************
      //**********************************************************************************************************************************************************
      //sélectionner le client
      Search_Client(rootClient1);
      
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient1,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient1,10).DblClick();
      
      //Tab Agenda
      var eventDescription=new Array(); //utilisé pour stocker les noms des événements 
      var eventType=new Array(); //utilisé pour stocker les types des événements 
       
      Get_WinDetailedInfo_TabAgendaForClient().Click();
      Get_WinDetailedInfo_TabAgendaForClient().WaitProperty("IsSelected", true, 30000);
      var eventCount=Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().Items.Count
  
      for(var i=0;i<=eventCount-1;i++){
        eventDescription[i]=Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().Items.Item(i).ShortDescription
        eventType[i]=Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().Items.Item(i).Type
      }      
      Get_WinDetailedInfo_BtnOK().Click();
      
      //Dans la section détails, positionner le curseur sur le client racine secondaire
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient1,10).Click();
      
      //Validation de données dans la  partie détail 
      //Tab Agenda
      Get_ClientsDetails_TabAgenda().Click()
      Get_ClientsDetails_TabAgenda().WaitProperty("IsSelected", true, 30000);
      if(Get_ClientsDetails_TabAgenda_DgvContactsData().WPFObject("RecordListControl", "", 1).Items.Count==eventCount){  
        for(i=0;i<=eventCount-1;i++){      
           aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"Comment",cmpEqual,eventDescription[i])
           aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"TypeForDisplay",cmpEqual,eventType[i])
         }
      }
      else{
        Log.Error("Le nombre d’évènements  est erroné")
      }
                     
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();

 }
