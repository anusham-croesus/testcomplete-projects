//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions

/* Description : Aller au module "Modeles".Afficher la fenêtre "Comptes" en cliquant sur Assigner-Compte dans la partie « détail»
 Vérifier la présence des contrôles et des étiquetés  */
 
 function Survol_Mod_Details_Assign_Accounts()
 {
  var type="account";
  
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click()
  Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click()
 
   //Les points de vérification en français 
   if(language=="french"){Check_Properties_French(type)}   
    //Les points de vérification en anglais 
   else {Check_Properties_English(type)}
   
  Check_Existence_Of_Controls()
     
  Get_WinPickerWindow_BtnCancel().Click()
        
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar(); 
 }

 //Fonctions  (les points de vérification pour les scripts qui testent Details_Assign)
function Check_Properties_French(type)
{
  //titre
  if(type=="account"){aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, "Comptes")};
  if(type=="client"){
      if (client == "BNC" || client == "TD" ){
        aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, "Clients racines")
      }
      else{//RJ ou CIBC
        aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, "Clients")
      }
  };
  if(type=="relationship"){aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, "Relations")};
  
  //btns
  aqObject.CheckProperty(Get_WinPickerWindow_BtnOK().Content, "OleValue", cmpEqual, "OK");
  aqObject.CheckProperty(Get_WinPickerWindow_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
  
  //les en têtes
  if(type=="account"){aqObject.CheckProperty(Get_WinPickerWindow_ChAccountNo().Content, "OleValue", cmpEqual, "No compte");}
  if(type=="client"){
    if (client == "BNC" || client == "TD" ){
      aqObject.CheckProperty(Get_WinPickerWindow_ChRootNo().Content, "OleValue", cmpEqual, "No racine")
    }
    else{   // CIBC
      aqObject.CheckProperty(Get_WinPickerWindow_ChClientNo().Content, "OleValue", cmpEqual, "No client")
    }
  };
  if(type=="relationship"){aqObject.CheckProperty(Get_WinPickerWindow_ChRelationshipNo().Content, "OleValue", cmpEqual, "No relation")};
  aqObject.CheckProperty(Get_WinPickerWindow_ChName().Content, "OleValue", cmpEqual, "Nom");
}

function Check_Properties_English(type)
{
  //titre
  if(type=="account"){aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, "Accounts")};
  if(type=="client"){
    if (client == "BNC" ){
      aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, "Root Clients")
    }
    else{//RJ
      aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, "Clients")
    }
  };
  if(type=="relationship"){aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, "Relationships")};
  
  //btns
  aqObject.CheckProperty(Get_WinPickerWindow_BtnOK().Content, "OleValue", cmpEqual, "OK");
  aqObject.CheckProperty(Get_WinPickerWindow_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
  
  //les en têtes
  if(type=="account"){aqObject.CheckProperty(Get_WinPickerWindow_ChAccountNo().Content, "OleValue", cmpEqual, "Account No.")};
  if(type=="client"){
    if (client == "BNC" ){
      aqObject.CheckProperty(Get_WinPickerWindow_ChRootNo().Content, "OleValue", cmpEqual, "Root No.")
    }
    else{
       aqObject.CheckProperty(Get_WinPickerWindow_ChClientNo().Content, "OleValue", cmpEqual, "Client No.")
    }
  };
  if(type=="relationship"){aqObject.CheckProperty(Get_WinPickerWindow_ChRelationshipNo().Content, "OleValue", cmpEqual, "Relationship No.")};
  aqObject.CheckProperty(Get_WinPickerWindow_ChName().Content, "OleValue", cmpEqual, "Name");
}

function Check_Existence_Of_Controls()
{
 aqObject.CheckProperty(Get_WinPickerWindow_BtnOK(), "IsVisible", cmpEqual, true);
 aqObject.CheckProperty(Get_WinPickerWindow_BtnOK(), "IsEnabled", cmpEqual, true);
 
 aqObject.CheckProperty(Get_WinPickerWindow_BtnCancel(), "IsVisible", cmpEqual, true);
 aqObject.CheckProperty(Get_WinPickerWindow_BtnOK(), "IsEnabled", cmpEqual, true);
}

