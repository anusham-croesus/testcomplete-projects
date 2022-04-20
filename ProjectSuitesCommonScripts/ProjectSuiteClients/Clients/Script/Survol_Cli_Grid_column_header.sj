//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Transactions_Get_functions


/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Afficher tous les en-têtes des colonnes dans une table (grid) en appelant le menu contextuel (Clique droite), 
vérifier le texte des en-têtes. */

function Survol_Cli_Grid_column_header()
{
    try {
        Login(vServerClients, userName , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        
        Get_MainWindow().Maximize();    
        //Les points de vérification en français 
        Check_Properties(language)
        
        Get_MainWindow().Restore();  
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); 
    }
}


//Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties(language)
{
    //Vérification des entêtes de colonnes par défaut 
    
    Get_ClientsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","MenuItem_c549");
    
    aqObject.CheckProperty(Get_ClientsGrid_ChName(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",3,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChClientNo(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",4,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChIACode(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",5,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone1(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",6,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone2(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",7,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChBalance(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",8,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChCurrency(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",9,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChMargin(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",10,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChLastContact(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",11,language)); //EM: 90-07-23-CO : selon Karima le Jira: CROES-785 est appliqué pour tous.
    Log.Message("La réponse de Karima 12/02/2018 : CROES-785")
    aqObject.CheckProperty(Get_ClientsGrid_ChAge(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",12,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone3(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",13,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone4(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",14,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",15,language));
   
    
    //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
    Get_ClientsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    
    if ( client == "BNC"  ){
      aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 17);//EM : 90.10.Fm-2 : Modifié suite èa l'ajout d'une nouvelle colonne Discrétionnaire. //Il faut valider si le profil devrait être visible quand la liste est vide
    } 
    if(client == "US" || client == "RJ"){
      aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 15);
    } 
    
     if (client == "TD" ||client == "CIBC" ){
     Log.Message(" CROES-7231");
      //aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 14);//Il faut valider si le profil devrait être visible quand la liste est vide
    } 
//    if(client != "BNC"  &&  client!= "CIBC"&& client != "US" && client != "TD" ){
//      aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 13);
//    }
    
    //Vérification des entêtes de colonnes
    Add_AllColumns();  
    aqObject.CheckProperty(Get_ClientsGrid_ChName(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",20,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChClientNo(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",21,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChIACode(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",22,language));
    
    aqObject.CheckProperty(Get_ClientsGrid_ChIACode(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",22,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTelType4(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",23,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTelType3(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",24,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTelType2(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",25,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTelType1(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",26,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChSegmentation(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",27,language));
    
    if (client == "BNC"){
      aqObject.CheckProperty(Get_ClientsGrid_ChRepresentative(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",30,language));
    if (client == "BNC" ||client == "TD" )  
      aqObject.CheckProperty(Get_ClientsGrid_ChModelName() , "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",46,language));
    }
      
    aqObject.CheckProperty(Get_ClientsGrid_ChFullName(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",28,language)); 
     if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){ 
      aqObject.CheckProperty(Get_ClientsGrid_ChModelNumber() , "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",47,language));
    }
    aqObject.CheckProperty(Get_ClientsGrid_ChLangue(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",29,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChDateOfBirth(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",31,language));    
    aqObject.CheckProperty(Get_ClientsGrid_ChEmail3(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",32,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChEmail2(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",33,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChEmail1(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",34,language));
    
    if(client != "CIBC"){       // Adapté pour CIBC
          aqObject.CheckProperty(Get_ClientsGrid_ChDiscretionary(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",48,language));
          }
    if(client == "CIBC" || client == "TD"){Scroll();} 
    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone1(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",36,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone2(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",37,language));
    
     Scroll();
    aqObject.CheckProperty(Get_ClientsGrid_ChBalance(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",38,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChCurrency(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",39,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChMargin(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",40,language));
    if(client=="CIBC" || client == "TD"){aqObject.CheckProperty(Get_ClientsGrid_ChLastContact(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",51,language));}
    else{
    aqObject.CheckProperty(Get_ClientsGrid_ChLastContact(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",41,language));}
    aqObject.CheckProperty(Get_ClientsGrid_ChAge(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",42,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone3(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",43,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone4(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",44,language));
    aqObject.CheckProperty(Get_ClientsGrid_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Clients,"Grid_column_header",45,language));
     
}

 function Scroll()
{
    //cliquer sur scrollbar pour faire l'entête de colonne visible
    var ControlWidth=Get_RelationshipsClientsAccountsGrid().get_ActualWidth()
    var ControlHeight=Get_RelationshipsClientsAccountsGrid().get_ActualHeight()
    for (i=1; i<=7; i++) { Get_RelationshipsClientsAccountsGrid().Click(ControlWidth-40, ControlHeight-3)}     
}

function Add_AllColumns()
{
    Get_ClientsGrid_ChIACode().ClickR(); 
    Get_ClientsGrid_ChIACode().ClickR(); 
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
   // for(i=1; i<=count; i++)
   while (Get_GridHeader_ContextualMenu_AddColumn().IsEnabled){
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click(); 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_ClientsGrid_ChIACode().ClickR();
    }  
}


