//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4283
    
   
    Description :Suppression d’une sélection de clients á la fois.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-6--V9-croesus-co7x-1_5_565
    
    Date: 12/04/2019
*/

function Regression_Croes_4283_Cli_DeleteSelectedClients()
{
  try{ 
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4283", "Croes-4283");
      var fictifClient=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "clientFictif", language+client);
      var externClient=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "clientExterne", language+client);
      var RealClient=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "realClient", language+client);
      var IACode=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "IACode", language+client);
      
      //Accès au module client
      Login(vServerClients, userName,psw,language);
      Get_ModulesBar_BtnClients().Click();       
      
      //Créer un client fictif
      Get_MainWindow().Maximize();
      CreateFictitiousClient(fictifClient)
      
      //Créer un client externe
      CreateExternalClient(externClient, IACode)
      
      //Sélectioner ces clients
      var ClientFicNo=Get_RelationshipsClientsAccountsGrid().FindChild("Value", fictifClient, 10).DataContext.DataItem.ClientNumber.OleValue
      var ClientExternNo=Get_RelationshipsClientsAccountsGrid().FindChild("Value", externClient, 10).DataContext.DataItem.ClientNumber.OleValue
      
      var clients= new Array(ClientExternNo, ClientFicNo);
      for (var i =0 ; i < clients.length; i++){          
        
        Log.Message("numeros Client :");
        Log.Message(clients[i]);
       }
      SelectClients(clients)
      
      //Supprimer les clients sélectionnés      
      Get_Toolbar_BtnDelete().Click();
      Get_DlgConfirmation_BtnRemove().Click();
      
      //valider la suppression des clients créés
          
      if (fictifClient.Exists ==true || externClient.Exists==true )
       Log.Error("Les clients sélectionnés ne sont pas supprimé")
        else
       Log.Checkpoint("les clients sélectionnés sont supprimés") 
              
      //Sélectionner un client réel 800214
      var numberOftries=0;  
      while ( numberOftries < 5 && Get_WinQuickSearch().Exists == true){
      Get_Toolbar_BtnSearch().Click();
      numberOftries++;
          break;
      }
      Search_Client(RealClient);
      
      //Valider que le bouton supprimer est grisé est inaccessible 
      aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"Exists", cmpEqual, true)
      aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"Enabled", cmpEqual, false)    
      aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"IsEnabled", cmpEqual, false)
        
   
  }
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
  finally {
       Terminate_CroesusProcess();
    }
}
