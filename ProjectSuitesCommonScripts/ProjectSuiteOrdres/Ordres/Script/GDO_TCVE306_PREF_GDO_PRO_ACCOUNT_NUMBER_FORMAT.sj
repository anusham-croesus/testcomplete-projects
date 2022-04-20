//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    Jira                 :  TCVE-306
    Description          :  GDO valider avec la pref: PREF_GDO_PRO_ACCOUNT_NUMBER_FORMAT = null
    Préconditions        : 
    
    Auteur               :  Youlia Raisper
    Version de scriptage :	90.14-Lu-47
  
    
*/


function GDO_TCVE306_PREF_GDO_PRO_ACCOUNT_NUMBER_FORMAT() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/TCVE-306");
            Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_PRO_ACCOUNT_NUMBER_FORMAT",null,vServerOrders);            
            RestartServices(vServerOrders);
            
            //fermer les fichiers excel
            while(Sys.waitProcess("EXCEL").Exists){Sys.Process("EXCEL").Terminate();}
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var openOrder=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "openOrder", language+client);
            var columnPro=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "columnProtext", language+client); 
            var proAccountText=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "proAccount", language+client); 
             
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnOrders().Click();
                       
            /*Se loguer avec keynej.Aller dans le module Compte.Faire un right clik sur l'entête des colonnes.Cliquer sur Ajouter une colonne*/
            Log.Message("Se loguer avec keynej.Aller dans le module Compte.Faire un right clik sur l'entête des colonnes.Cliquer sur Ajouter une colonne");

            Get_ModulesBar_BtnAccounts().Click();   
            SetAutoTimeOut();          
            if(!Get_AccountsGrid_ChPro().Exists){
                Get_AccountsGrid_ChName().ClickR();
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();                
                 if(Get_GridHeader_ContextualMenu_AddColumn_Pro().Exists){
                   Log.Error("la colonne Pro est visible"); 
                 }
                 else{
                   Log.Checkpoint("la colonne Pro n'est pas visible");
                 }
            }else{
              Log.Error("la colonne Pro est visible");
            }
            RestoreAutoTimeOut();
            
            Log.Message("Aller dans le module des ordres.");
            Get_ModulesBar_BtnOrders().Click();
            
            Log.Message("Dans le browser (blotter) sélectionner le premier ordre qui a la valeur = 'Ouvert' sous la colonne État"); 
            Get_OrderGrid().Find("Value",openOrder,10).Click();
            
            Log.Message("Dans la barre de  menu cliquer sur le bouton rapports.Sélectionner 'Rapport des ordres Fidessa'.Répondre OK au message");   
            Get_MenuBar_Reports().Click();
            Get_MenuBar_Reports_FidessaOrderReport().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
            
            //fermer les fichiers excel
            while(Sys.waitProcess("EXCEL").Exists){Sys.Process("EXCEL").Terminate();}
                                              
            /*la colonne Pro n'est pas visible dans le rapport Excel.*/
            Log.Message("Valifer que la colonne Pro n'est pas visible dans le rapport Excel.");
            var sTempFolder = Sys.OSInfo.TempDirectory;
            var folderName=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%b%d")
            Log.Message(sTempFolder+"\CroesusTemp\\Executions\\",folderName+"*")
            var folderPath= FolderFinder(sTempFolder+"\CroesusTemp\\Executions\\",folderName+"*")
            Log.Message(folderName)
            Log.Message(folderPath);
                        
            var fileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%d")        
                  
            var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(VarToStr(folderPath),fileNameContains), aqFile.faRead, aqFile.ctANSI);               
            // Reads text lines from the file and posts them to the test log 
            var countLineInMyFile=0; // les lignes dans le fichier 
            var found=false;
            while(! myFile.IsEndOfFile()){    
              countLineInMyFile++;
              line = myFile.ReadLine();
              // Split at each space character.
              var textArr = line.split("	"); 
              var lengthOfArr=textArr.length
              //Log.Message(line)      
                if(countLineInMyFile==1){  
                    for(var i=0; i<lengthOfArr;i++){
                        if(aqString.Unquote(VarToString(textArr[i]))==columnPro || aqString.Unquote(VarToString(textArr[i]))== proAccountText){                          
                          Log.Error("La colonne Pro est visible");
                          found=true 
                          break;
                        }
                    }                    
                }                                                           
            } 
            if(found==false){
              Log.Checkpoint("La colonne Pro n'est pas visible");   
            }
            //Fermer l'application
            Terminate_CroesusProcess(); 
      }
      catch (e) {                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));

      }
      finally {
        
            Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_PRO_ACCOUNT_NUMBER_FORMAT","^.{8}A",vServerOrders);            
            RestartServices(vServerOrders);
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language); 
            Get_ModulesBar_BtnAccounts().Click(); 
            SetAutoTimeOut();            
            if(!Get_AccountsGrid_ChPro().Exists){
                Get_AccountsGrid_ChName().ClickR();
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();                
                 if(Get_GridHeader_ContextualMenu_AddColumn_Pro().Exists){
                   Log.Checkpoint("la colonne Pro est visible"); 
                 }
                 else{
                   Log.Error("la colonne Pro n'est pas visible");
                 }
            }else{
              Log.Checkpoint("la colonne Pro est visible");
            }
            RestoreAutoTimeOut();
             //Supprimer les fichiers 
            aqFileSystem.DeleteFile(folderPath + "*.*");  
            //Fermer l'application
            Terminate_CroesusProcess(); 
            Runner.Stop(true);                         
        }
}