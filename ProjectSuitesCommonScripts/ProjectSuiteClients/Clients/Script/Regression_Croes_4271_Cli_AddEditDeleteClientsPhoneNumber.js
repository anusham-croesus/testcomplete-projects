//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4271
    
   
    Description :Valider qu'il est possible d'ajouter, modifier et de supprimer des numéros de téléphones des clients.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-2--V9-croesus-co7x-1_5_565
    
    Date: 29/03/2019
*/


function Regression_Croes_4271_Cli_AddEditDeleteClientsPhoneNumber()
{

  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4271", "Croes-4271");

    
     var clientNum=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNum_4271", language+client);
     var phoneNumber=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "phoneNumber", language+client);
     var type=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "typeCell", language+client);
     
    //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    //Sélectionner le client 800228    
    Search_Client(clientNum);
    
    //Aller sur Info et sélectionner Adresse    
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);

    //valider l'affichage de la séction Téléphones
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones(),"VisibleOnScreen", cmpEqual, true)
    
    //Ajouter un numéro de téléphone
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnAdd().Click();
    Get_WinCRUTelephone_CmbType().Click();
    Get_WinCRUTelephone_CmbType().set_SelectedIndex(2);//Bureau
    Get_WinCRUTelephone_TxtNumber().Keys(phoneNumber);
    Get_WinCRUTelephone_BtnOK().Click();
    
    //valider l'ajout du numéro de téléphone
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild("Text",phoneNumber , 10), "Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild("Text",phoneNumber , 10), "VisibleOnScreen", cmpEqual, true)

    //Modifier le type du premier n de tél
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "4"], 10).Click();
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnEdit().Click();
    aqObject.CheckProperty(Get_WinCRUTelephone(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinCRUTelephone(),"VisibleOnScreen", cmpEqual, true)
    Get_WinCRUTelephone_CmbType().Click();
    Get_WinCRUTelephone_CmbType().set_SelectedIndex(3);//Cellulaire
    Get_WinCRUTelephone_BtnOK().Click();
    Get_WinDetailedInfo_BtnOK().Click();
    
    //Valider la modification
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
    var cell= Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "4"], 10).DataContext.Item(0).Data.OleValue
    Log.Message(cell);
    Log.Message(type);
     if (cell== type)
      Log.Checkpoint("La modification est appliquée")
    else
      Log.Error("L'affichage est différent de "+type+" la modification n'est pas appliquée")
      
    //Supprimer le n ajouté
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild("Text",phoneNumber , 10).Click();
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnDelete().WaitProperty("IsEnabled", true, 15000);
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnDelete().Click();
    Get_DlgConfirmation_BtnRemove().WaitProperty("IsEnabled", true, 15000);  
    Get_DlgConfirmation_BtnRemove().Click();
    
    //valider que le numéro de tél n'est plus affiché
    if ( (Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild("Text",phoneNumber , 10).Exists== true) && (Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild("Text",phoneNumber , 10).VisibleOnScreen== true))
     Log.Error("Le numéro ajouté " +phoneNumber+" n'est pas supprimé")
      else 
     Log.Checkpoint("Le numéro ajouté "+phoneNumber+" est supprimé")
     
//     //rétablir la config initiale
//     Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "4"], 10).Click();
//     Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnEdit().Click();
//     Get_WinCRUTelephone_CmbType().set_Text("1")
//     Get_WinCRUTelephone_BtnOK().Click();
//     Get_WinDetailedInfo_BtnOK().Click();
    } 
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    
  }  
}
