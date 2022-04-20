//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6260
   
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-10-Fm-6--V9-croesus-co7x-1_5_565
*/


function CR908_6260_Client_ValidateCustomerStatusWithPREFENABLECIENTSTATUS1()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6260");
         
          //	Mettre la préférence PREF_ENABLE_CLIENT_STATUS = 1
           Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_CLIENT_STATUS","1",vServerClients);
           RestartServices(vServerClients);
           /*1. Se loguer avec KEYNEJ et aller dans le module Clients*/
           userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
           //Les varibales
           var numberClient800238=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberClient800238", language+client);
           var numberClient800222=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberClient800222", language+client);
           var numberClient800240=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberClient800240", language+client);
           var numberClient800253=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberClient800253", language+client);
           var numberClient800078=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberClient800078", language+client);
           var statuClientOpen=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "statuClientOpen", language+client);
           var statuClientClosed=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "statuClientClosed", language+client);
           var statuClientDeleted=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "statuClientDeleted", language+client);
           Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language)
           
           
           if(client == "CIBC"){
                statuClientClosed  = statuClientOpen;
                statuClientDeleted = statuClientOpen;
           }
           
           //Choisir le module client
           Get_ModulesBar_BtnClients().Click();
           /*2. Faire  un recherche du client 800238*/
           Search_Client(numberClient800238);
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800238, 10).Click();
           /*3. Faire info client */
           Get_ClientsBar_BtnInfo().Click();
           /*Les points de vérifications : Le champ État = Ouvert Anglais le champ Status = Open*/
           aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtStatusForRelationship(), "Text", cmpEqual, statuClientOpen);
           Get_WinDetailedInfo_BtnCancel().Click();
           
           /*Faire la recherche du client 800222*/
           Search_Client(numberClient800222);
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800222, 10).Click();
           /*3. Faire info client */
           Get_ClientsBar_BtnInfo().Click();
           /*Les points de vérifications : Le champ État = Ouvert Anglais le champ Status = Open*/
           aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtStatusForRelationship(), "Text", cmpEqual, statuClientOpen);
           Get_WinDetailedInfo_BtnCancel().Click();
           /*Faire la recherche du client 800240*/
           Search_Client(numberClient800240);
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800240, 10).Click();
           /*3. Faire info client */
           Get_ClientsBar_BtnInfo().Click();
           /*Les points de vérifications : Le champ État = Ouvert Anglais le champ Status = Closed*/
           aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtStatusForRelationship(), "Text", cmpEqual, statuClientClosed);
           Get_WinDetailedInfo_BtnCancel().Click();
           
            /*Faire la recherche du client 800253*/
           Search_Client(numberClient800253);
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800253, 10).Click();
           /*3. Faire info client */
           Get_ClientsBar_BtnInfo().Click();
           /*Les points de vérifications : Le champ État = Ouvert Anglais le champ Status = Closed*/
           aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtStatusForRelationship(), "Text", cmpEqual, statuClientClosed);
           Get_WinDetailedInfo_BtnCancel().Click();
            /*Faire la recherche du client 800078*/
           Search_Client(numberClient800078);
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800078, 10).Click();
           /*3. Faire info client */
           Get_ClientsBar_BtnInfo().Click();
           /*Les points de vérifications : Le champ État = Ouvert Anglais le champ Status = Closed*/
           aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtStatusForRelationship(), "Text", cmpEqual, statuClientDeleted);
          Get_WinDetailedInfo_BtnCancel().Click();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Terminate_CroesusProcess();
  
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
       
      
        
    }
}
