//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    La liste des profiles est en ordre alphabétiques pour le menu configuration de clonne dans l'ancienne version de prod(UA)T. Cependant avec la nouvelle version, 
    la liste n'est pas en ordre alphabétique. Cela cause de la confusion pour le client. 

    Auteur :                Abdel Matmat
    Anomalie:               CROES-6661
    Version de scriptage:	90-08-Dy-2
    Date :                  09/01/2019
*/


function CROES_6661_ProfilesAreNotInAlphabeticalOrderInColumnConfiguration() {
         
           try {
                Log.Link("https://jira.croesus.com/browse/CROES-6661", "Cas de tests JIRA CROES-6661");
           
                var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
                var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                   
                //Se connecter à croesus    
                Login(vServerClients, userNameUNI00, passwordUNI00, language);
                Get_ModulesBar_BtnClients().Click();
                Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);  
                Get_MainWindow().Maximize();
                    
                //Acceder au menu contextuel et vérifier l'ordre alpabétique
                Get_ClientsGrid_ChCurrency().ClickR();
                Get_ClientsGrid_ChCurrency().ClickR();
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
                WaitObject(Get_SubMenus(),["ClrClassName","WPFControlOrdinalNo"],["MenuItem","1"])
                CheckAlphabeticalSortProfiles();
          } 
          catch (e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 
                    
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    Terminate_IEProcess();    
          }
}


function CheckAlphabeticalSortProfiles()
{
   var SubMenu = Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1)
   var count = SubMenu.DataContext.Profiles.Count;
   var arr = []; 
   
   for(var i=0; i<=count-1; i++) 
   { 
     if (language == "french"){
         arr.push( aqString.Replace(aqString.ToLower(SubMenu.DataContext.Profiles.Item(i).ShortDescriptionL1),"é","e"));
         arr[i] = aqString.Replace(arr[i],"à","a");
         arr[i] = aqString.Replace(arr[i],"è","e");
         arr[i] = aqString.Replace(arr[i],"ê","e");
     }
     else
         arr.push( aqString.ToLower(SubMenu.DataContext.Profiles.Item(i).ShortDescriptionL2));  
     Log.Message(arr[i]);
   }
   for (i = 0; i < count-1; i++)
   {
      if (arr[i] > arr[i+1])
      {
            Log.Error("La liste des profils n'est pas triée par ordre alphabétique ascendant ==> "+arr[i]+" est supérieur à "+arr[i+1]);
      }else {
            Log.Checkpoint("La liste des profils est triée par ordre alphabétique ascendant");  
      }
    }
    
}
