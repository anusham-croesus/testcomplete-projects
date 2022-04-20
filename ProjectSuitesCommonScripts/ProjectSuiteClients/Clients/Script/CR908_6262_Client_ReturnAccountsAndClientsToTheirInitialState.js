//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**


        
     https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6262
    Auteur : Sana Ayaz
    
    Version de scriptage:		ref90-10-Fm-6--V9-croesus-co7x-1_5_565
*/


function CR908_6262_Client_ReturnAccountsAndClientsToTheirInitialState()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6262");
          //Les variables
          //Les numéros des comptes
           var numberAccomp800222LV=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberAccomp800222LV", language+client);
           var numberAccomp800240NA=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberAccomp800240NA", language+client);
           var numberAccomp800240OB=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberAccomp800240OB", language+client);
           var numberAccomp800253LY=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberAccomp800253LY", language+client);
           var numberAccomp800253NA=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberAccomp800253NA", language+client);
           var numberAccomp800078NA=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberAccomp800078NA", language+client);
           var numberAccomp800078OB=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberAccomp800078OB", language+client);
           var numberAccomp800015RE=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberAccomp800015RE", language+client);
           var numberAccomp800015SF=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberAccomp800015SF", language+client);
           //Les numéros des clients
           var numberClient800222=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberClient800222", language+client);
           var numberClient800240=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberClient800240", language+client);
           var numberClient800253=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberClient800253", language+client);
           var numberClient800078=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberClient800078", language+client);
           var numberClient800015=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR908", "numberClient800015", language+client);
           
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           
           //Les numéros des clients
           
            /*2	
              Exécuter les requêtes suivantes
 
              update b_compte set status=2 where no_compte = '800222-LV'
              update b_compte set status=2 where no_compte = '800240-NA'
              update b_compte set status=2 where no_compte = '800240-OB'
              update b_compte set status=2 where no_compte = '800253-LY'
              update b_compte set status=3 where no_compte = '800253-NA'
              update b_compte set status=3 where no_compte = '800078-NA'
              update b_compte set status=3 where no_compte = '800078-OB'
              update b_compte set status=2 where no_compte = '800015-RE'
              update b_compte set status=3 where no_compte = '800015-SF'
 
              select no_compte, status from b_compte where no_compte in ('800222-LV','800240-NA', '800240-OB', '800253-LY', '800253-NA', '800078-NA', '800078-OB',   '800015-RE',   '800015-SF' ) */
         
               Execute_SQLQuery(" update b_compte set status=1 where no_compte ='"+numberAccomp800222LV+"'",vServerClients)   
               Execute_SQLQuery(" update b_compte set status=1 where no_compte ='"+numberAccomp800240NA+"'",vServerClients)
               Execute_SQLQuery(" update b_compte set status=1 where no_compte ='"+numberAccomp800240OB+"'",vServerClients)
               Execute_SQLQuery(" update b_compte set status=1 where no_compte ='"+numberAccomp800253LY+"'",vServerClients)
               Execute_SQLQuery(" update b_compte set status=1 where no_compte ='"+numberAccomp800253NA+"'",vServerClients)
               Execute_SQLQuery(" update b_compte set status=1 where no_compte ='"+numberAccomp800078NA+"'",vServerClients)
               Execute_SQLQuery(" update b_compte set status=1 where no_compte ='"+numberAccomp800078OB+"'",vServerClients)
               Execute_SQLQuery(" update b_compte set status=1 where no_compte ='"+numberAccomp800015RE+"'",vServerClients)
               Execute_SQLQuery(" update b_compte set status=1 where no_compte ='"+numberAccomp800015SF+"'",vServerClients)
               //select no_compte, status from b_compte where no_compte in ('800222-LV','800240-NA', '800240-OB', '800253-LY', '800253-NA', '800078-NA', '800078-OB',   '800015-RE',   '800015-SF' )
               var arrayAccompt=Execute_SQLQuery_GetFieldAllValues("select status from b_compte where no_compte in ('"+numberAccomp800222LV+"','"+numberAccomp800240NA+"','"+numberAccomp800240OB+"','"+numberAccomp800253LY+"','"+numberAccomp800253NA+"','"+numberAccomp800078NA+"','"+numberAccomp800078OB+"','"+numberAccomp800015RE+"','"+numberAccomp800015SF+"' )", vServerClients, "status");
               var arrayStatusAccompt = new Array(1,1,1,1,1,1,1,1,1);
          
               Log.Message(arrayAccompt)

              for(i=0; i<9; i++)
                 {
               CheckEquals(arrayAccompt[i],arrayStatusAccompt[i],"Le status des comptes")
                 }  
               
                //lancer la commande loader suivante :
                ExecuteSSHCommandCFLoader("CR980", vServerClients, "cfLoader -ClientStatusProcessor -FIRM=FIRM_1", userNameKEYNEJ);
                
                //select no_client, status from b_client where no_client in ('800222','800240', '800253', '800078', '800015')
               var arrayClient=Execute_SQLQuery_GetFieldAllValues("select status from b_client where no_client in ('"+numberClient800222+"','"+numberClient800240+"','"+numberClient800253+"','"+numberClient800078+"','"+numberClient800015+"' )" , vServerClients, "status");
               var arrayStatusClient = new Array(1,1,1,1,1);
          
               Log.Message(arrayAccompt)

              for(i=0; i<5; i++)
                 {
               CheckEquals(arrayClient[i],arrayStatusClient[i],"Le status des clients")
                 }  
                 //	1. Se loguer dans le configurateur au niveau FIRME et mettre la préférence PREF_ENABLE_CLIENT_STATUS = 0
           Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_CLIENT_STATUS","0",vServerClients);
           RestartServices(vServerClients);

          
    }   
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
       
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        
      
        
    }
}