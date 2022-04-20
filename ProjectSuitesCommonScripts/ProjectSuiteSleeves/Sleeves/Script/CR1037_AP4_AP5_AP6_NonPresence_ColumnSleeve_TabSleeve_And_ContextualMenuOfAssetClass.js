//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.
    Ce cas de test valider que si la pref PREF_ENABLE_SLEEVES est a non pour un user donné
    la colonne sleeve , le bouton sleeve et dans ContextualMenu l option slevve n est pas presente 
Analyste d'automatisation: Alhassane Diallo */


function CR1037_AP4_AP5_AP6_NonPresence_ColumnSleeve_TabSleeve_And_ContextualMenuOfAssetClass()
{
      try{   
          
         
         
         Log.Message("****************Le cas AP4, AP et AP6 avec JEFFET *****************")
         RestartServices(vServerSleeves); 
         var user2      = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "JEFFET", "username");
         var account2   = GetData(filePath_Sleeves, "DataPool_WithoutModel", 5);
         
         Activate_Inactivate_Pref(user2,"PREF_ENABLE_SLEEVES","NO",vServerSleeves);
         
         Log.PopLogFolder();
         logEtape1 = Log.AppendFolder("Étape 1: se connecter avec le user JEFFET  ");
         Login(vServerSleeves, user2 ,psw,language);
         
         Log.PopLogFolder();
         logEtape2 = Log.AppendFolder("Étape 2: Valider que la colonne sleeve n'est pas prensente   ");
         NonPresence_of_ColumnSleeve()
         
         Log.PopLogFolder();
         logEtape3 = Log.AppendFolder("Étape 3: Valider que le bouton  sleeve n'est pas prensent   ");
         NonPresence_of_TabSleeve(account2)   
         
         Log.PopLogFolder();
         logEtape4 = Log.AppendFolder("Étape4: Valider que  dans ContextualMenu l option slevve n est pas presente "); 
         NonPresence_in_ContextualMenuOfAssetClass(account2)
         
          
         
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)   
    }
    finally {
    
      Terminate_CroesusProcess(); //Fermer Croesus
      Activate_Inactivate_Pref(user2,"PREF_ENABLE_SLEEVES","YES",vServerSleeves);
    }
}

//Le script
function NonPresence_of_ColumnSleeve()
{
    
           
     //var account= GetData(filePath_Sleeves, "DataPool_WithoutModel", 6);              
     var sleeveItem=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "sleeveItem_AP1_AP4", language+client)
        
     Get_ModulesBar_BtnAccounts().Click();
                          
     //Verification
     if(CheckNonPresenceOfColumnToAdd(sleeveItem)){
       Log.Error("L'item "+sleeveItem+" est présent")
     }
     else{
       Log.Checkpoint("L'item "+sleeveItem+" n'est pas présent")
     }
}


//Valide si la colonne présente
function CheckNonPresenceOfColumnToAdd(item)
{
   Get_AccountsGrid_ChName().ClickR();
   Get_AccountsGrid_ChName().ClickR();
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   
   Get_AccountsGrid_ChName().ClickR();
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
   var found=false;
   
   var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount
  
   
   for(var i=1; i<count; i++){  
      if(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("MenuItem", "", i).WPFControlText==item){
          found=true;
          return found;
      }
   }
   return found;
}
//Le script
function NonPresence_of_TabSleeve(account)
{
   
                      
    var tabDescription=GetData(filePath_Sleeves, "CreationOfSleeves", 123, language);
         
    Get_ModulesBar_BtnAccounts().Click();
                  
    //Valider la présence des segments         
    Get_ModulesBar_BtnAccounts().Click();         
    Search_Account(account);
    Get_AccountsBar_BtnInfo().Click();
         
    //Verification
    if(CheckNonPresenceOfTab(Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1) ,tabDescription)){
      Log.Error("L'onglet "+tabDescription+" est présent")
    }
    else{
      Log.Checkpoint("L'onglet "+tabDescription+" n'est pas présent")
    }
         
    Get_WinDetailedInfo().Close();
         

}

//Le script
function NonPresence_in_ContextualMenuOfAssetClass(account)
{
     
       
      //var itemSleeves=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);
      if(language=="english"){
        var itemSleeves=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);
      }
      else{
        var itemSleeves="Segment" //"CROES-5795"
      } 
        
      
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
      while (Get_ModulesBar_BtnAccounts().IsChecked == false){ 
        Get_ModulesBar_BtnAccounts().Click();
      }        
      Search_Account(account);
      DragAccountToPortfolio(account); 
         
      //Verification
      if(CheckNonPresenceOfItemInContextualMenuAssetAllocation(itemSleeves)){
          Log.Error("L'item "+itemSleeves+" est présent")
      }
      else{
          Log.Checkpoint("L'item "+itemSleeves+" n'est pas présent")
      }
                            
      
}

function CheckNonPresenceOfItemInContextualMenuAssetAllocation(item)
{
  Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().DropDown();
  
   var found=false;   
   var count = Get_SubMenus().ChildCount
  
   for(var i=1; i<=count; i++){  
      //Log.Message(Get_SubMenus().WPFObject("ComboBoxItem", "", i).WPFControlText)
      if(Get_SubMenus().WPFObject("ComboBoxItem", "", i).WPFControlText==item){         
          found=true;
          break;
      }
   }
  return found;
}
