//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_AP3_AP6_NonPresence_in_ContextualMenuOfAssetClass()
{
      try{   
                      
         Log.Message("****************Le cas AP3 avec FERMIE*****************")
         var user1=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "FERMIE", "username");
         var account1= GetData(filePath_Sleeves, "DataPool_WithoutModel", 6);   
         NonPresence_in_ContextualMenuOfAssetClass(user1,account1)
         
         Log.Message("****************Le cas AP6 avec JEFFET*****************")
         var user2=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "JEFFET", "username");
         var account2= GetData(filePath_Sleeves, "DataPool_WithoutModel", 5);   
         NonPresence_in_ContextualMenuOfAssetClass(user2,account2)           
    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
    }
    finally {
    
      Terminate_CroesusProcess(); //Fermer Croesus
       
      Activate_Inactivate_Pref(user1,"PREF_ENABLE_SLEEVES","YES",vServerSleeves);
      Activate_Inactivate_Pref(user2,"PREF_ENABLE_SLEEVES","YES",vServerSleeves);
    }
}

//Le script
function NonPresence_in_ContextualMenuOfAssetClass(user,account)
{
      Activate_Inactivate_Pref(user,"PREF_ENABLE_SLEEVES","NO",vServerSleeves);
       
      //var itemSleeves=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);
      if(language=="english"){
        var itemSleeves=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);
      }
      else{
        var itemSleeves="Segment" //"CROES-5795"
      } 
        
      Login(vServerSleeves, user ,psw,language);
      Get_ModulesBar_BtnAccounts().Click();
                  
      //Valider la présence des segments         
      Get_ModulesBar_BtnAccounts().Click();         
      Search_Account(account);
      DragAccountToPortfolio(account); 
         
      //Verification
      if(CheckNonPresenceOfItemInContextualMenuAssetAllocation(itemSleeves)){
          Log.Error("L'item "+itemSleeves+" est présent")
      }
      else{
          Log.Checkpoint("L'item "+itemSleeves+" n'est pas présent")
      }
                            
      //Fermer l'application
      Close_Croesus_MenuBar();
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