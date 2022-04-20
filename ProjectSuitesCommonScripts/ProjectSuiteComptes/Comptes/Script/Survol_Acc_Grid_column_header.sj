//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Transactions_Get_functions
//USEUNIT Comptes_Get_functions

/* Description : Aller au module "Accounts" en cliquant sur BarModules-btnAccounts. Afficher tous les en-têtes des colonnes dans une table (grid) en appelant le menu contextuel (Clique droite), 
vérifier le texte des en-têtes. */

function Survol_Acc_Grid_column_header()
{
   Login(vServerAccounts, userName, psw, language);
   Get_ModulesBar_BtnAccounts().Click();
   WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
   //Delay(3000);
       
  //Les points de vérification en français 
  Check_Properties(language);
     
  Close_Croesus_MenuBar();
}

//Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties(language)
{
    //Vérification des entêtes de colonnes par défaut 
    
    Get_AccountsGrid_ChName().ClickR();
	Get_AccountsGrid_ChName().ClickR();
	Get_AccountsGrid_ChName().ClickR();

    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
   
    
    aqObject.CheckProperty(Get_AccountsGrid_ChName(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",3,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",4,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChIACode(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",5,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChType(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",6,language));
    //Regime
    aqObject.CheckProperty(Get_AccountsGrid_ChPlan(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",7,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChTelephone1(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",8,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChTelephone2(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",9,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChBalance(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",10,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChCurrency(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",11,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChMargin(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",12,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",13,language));
            
    //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
    Get_AccountsGrid_ChIACode().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    
    if (client == "BNC" ){
    Log.Message("Les colonnes qu'on voit pas sur CX sont suite a la désactivation du modéle 2.0 selon la réponse de Karima")
      aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 20); //A.A: 90.14.14 Lu: Ajout de 'Pro', Avant=19//EM: 90.12.12 HF :avant c'était 18 //YR 15 90-04-32 
    } //Il faut valider si le profil devrait être visible quand la liste est vide
    else {
    if(client == "TD" || client == "CIBC" ){ Log.Message(" CROES-7231 ");}
      Log.Message(" Suite a la correction de l'anomalie CROES-6505, on voit plus la colonne Joint Account ");
      aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual,12);
    } 
   /* else if (client == "TD"  ||  client == "CIBC"){
    Log.Message(" CROES-7231 ");
      aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual,14);
    } */
    //Vérification des entêtes de colonnes
    Add_AllColumns();
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize(); 
    
    aqObject.CheckProperty(Get_AccountsGrid_ChName(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",18,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",19,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChIACode(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",20,language));    
    aqObject.CheckProperty(Get_AccountsGrid_ChStatus(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",21,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChModelNumber() , "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",47,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChModelName() , "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",46,language));
    
    if (client == "BNC" ){
      aqObject.CheckProperty(Get_AccountsGrid_ChReserves() , "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",43,language)); //EM : 90.12.12 HF : Avant n'existe pas
      aqObject.CheckProperty(Get_AccountsGrid_ChSleeves(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",22,language));
      aqObject.CheckProperty(Get_AccountsGrid_ChSeparatelyManaged(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",23,language));
      aqObject.CheckProperty(Get_AccountsGrid_ChMandate(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",24,language));
      aqObject.CheckProperty(Get_AccountsGrid_ChManager(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",25,language));
    }
    aqObject.CheckProperty(Get_AccountsGrid_ChClientNo(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",33,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChFullName(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",31,language));
    Scroll();
    aqObject.CheckProperty( Get_AccountsGrid_ChManagementStartDate(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",26,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChLastTransaction(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",27,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChLastTrade(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",28,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChLanguage(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",29,language));
    Log.Message(" Suite a la correction de l'anomalie CROES-6505, on voit plus la colonne Joint Account ");
    if(client == "BNC"){
    aqObject.CheckProperty(Get_AccountsGrid_ChJointAccount(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",30,language));}
   
    aqObject.CheckProperty(Get_AccountsGrid_ChCreationDate(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",32,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChClosingDate(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",42,language));   

      
    
    aqObject.CheckProperty(Get_AccountsGrid_ChType(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",34,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChPlan(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",7,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChTelephone1(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",8,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChTelephone2(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",9,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChBalance(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",10,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChCurrency(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",11,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChMargin(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",12,language));
    aqObject.CheckProperty(Get_AccountsGrid_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Accounts,"Grid_column_header",13,language));

    Get_AccountsGrid_ChName().ClickR();
	Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Restore() 
}

 function Scroll()
{
    //cliquer sur scrollbar pour faire l'entête de colonne visible
    var ControlWidth=Get_RelationshipsClientsAccountsGrid().get_ActualWidth();
    var ControlHeight=Get_RelationshipsClientsAccountsGrid().get_ActualHeight();
    Get_RelationshipsClientsAccountsGrid().Click(ControlWidth-40, ControlHeight-3);
    //for (i=1; i<=7; i++) { Get_RelationshipsClientsAccountsGrid().Click(ControlWidth-40, ControlHeight-3)}     
}

function Add_AllColumns()
{
    Get_AccountsGrid_ChIACode().ClickR(); 
    Get_AccountsGrid_ChIACode().ClickR(); 
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
    Log.Message(count)
    if (Get_GridHeader_ContextualMenu_AddColumn_Profiles().Exists) count-=1;
    Log.Message("Nombre des colonnes a ajouter = "+count)
    for(i=1; i<=count; i++){
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click(); 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_AccountsGrid_ChIACode().ClickR();
    }  
}


