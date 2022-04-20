//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_AP1_AP4_NonPresence_of_ColumnSleeve()
{
      try{   
          
         Log.Message("****************Le cas AP1 avec FERMIE*****************")
         var user1=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "FERMIE", "username");
         NonPresence_of_ColumnSleeve(user1)
         
         Log.Message("****************Le cas AP4 avec JEFFET*****************")
         var user2=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "JEFFET", "username");
         NonPresence_of_ColumnSleeve(user2)
         
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
function NonPresence_of_ColumnSleeve(user)
{
     Activate_Inactivate_Pref(user,"PREF_ENABLE_SLEEVES","NO",vServerSleeves);
           
     //var account= GetData(filePath_Sleeves, "DataPool_WithoutModel", 6);              
     var sleeveItem=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "sleeveItem_AP1_AP4", language+client)
         
     Login(vServerSleeves, user ,psw,language);
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