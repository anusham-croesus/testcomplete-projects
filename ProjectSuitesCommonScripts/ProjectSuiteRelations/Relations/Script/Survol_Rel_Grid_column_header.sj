//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Relations_Get_functions


/* Description : Aller au module "Relationships" en cliquant sur BarModules-btnRelationships. Afficher tous les en-têtes des colonnes dans une table (grid) en appelant le menu contextuel (Clique droite), 
vérifier le texte des en-têtes. */

function Survol_Rel_Grid_column_header()
{
   Login(vServerRelations, userName, psw ,language);
   Get_ModulesBar_BtnRelationships().Click();
   WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
          
  //Les points de vérification en français 
  Check_Properties(language);
     
  Close_Croesus_AltQ();
}

//Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties(language)
{
    //Vérification des entêtes de colonnes par défaut    
    Get_RelationshipsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    Delay(3000);
    
    aqObject.CheckProperty(Get_RelationshipsGrid_ChName(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",3,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChRelationshipNo(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",4,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChIACode(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",5,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChBalance(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",6,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChCurrency(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",7,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChMargin(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",8,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",9,language));
       
    /*Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
    Get_RelationshipsGrid_ChCurrency().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    /*if(client=="US")
     aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 17); //Il faut valider si le profil devrait être visible quand la liste est vide
     else if (client == "TD" || client == "BNC"){
     Log.Message("JIRA CROES-4150");
       aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 18); //EM : 90.10.Fm-2 BNC : Modifié suite à l'ajout d'une nouvelle  colonne "Discrétionnaire".//Il faut valider si le profil devrait être visible quand la liste est vide
     } 
     else
    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 17); //Il faut valider si le profil devrait être visible quand la liste est vide.SA:J'ai mis 17 au lieu de 16 suite a la réponse de Karim pour CX puisqu'on a la colonne Facturable suite a l'activation de Billing sur CX 78*/
    
    //Vérification des entêtes de colonnes
    Add_AllColumns();
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize(); 
    
    aqObject.CheckProperty(Get_RelationshipsGrid_ChModelName(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",36,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChModelNumber(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",35,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChName(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",15,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChRelationshipNo(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",16,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChIACode(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",17,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChBalance(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",18,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChCurrency(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",19,language));  
    aqObject.CheckProperty(Get_RelationshipsGrid_ChType(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",20,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChSegmentation(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",21,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChRepresentative(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",22,language));
     if( client == "TD" || client == "RJ"){
       var ControlWidth=Get_RelationshipsClientsAccountsGrid().get_ActualWidth()
       var ControlHeight=Get_RelationshipsClientsAccountsGrid().get_ActualHeight()
       Get_RelationshipsClientsAccountsGrid().Click(ControlWidth-40, ControlHeight-3);
     } 
    if (client != "CIBC") 
        aqObject.CheckProperty(Get_RelationshipsGrid_ChAlternateName(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",23,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChSalutationName(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",24,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChFullName(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",25,language));
    if (client == "CIBC")
        aqObject.CheckProperty(Get_RelationshipsGrid_ChLastUpdate(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",38,language));
    else
        aqObject.CheckProperty(Get_RelationshipsGrid_ChLastUpdate(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",26,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChLanguage(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",27,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChCreation(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",28,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChEmail1(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",29,language));//CROES 3927
    aqObject.CheckProperty(Get_RelationshipsGrid_ChEmail3(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",30,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChEmail2(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",31,language));
    if (client != "CIBC")
        aqObject.CheckProperty(Get_RelationshipsGrid_ChDiscretionary(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",37,language)); //EM : 90.10.Fm-2 BNC : Modifié suite à l'ajout d'une nouvelle  colonne "Discrétionnaire".
    if( client == "US"){
       var ControlWidth=Get_RelationshipsClientsAccountsGrid().get_ActualWidth()
       var ControlHeight=Get_RelationshipsClientsAccountsGrid().get_ActualHeight()
       Get_RelationshipsClientsAccountsGrid().Click(ControlWidth-40, ControlHeight-3); 
       aqObject.CheckProperty(Get_RelationshipsGrid_ChMargin(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",33,language));
       
    }
    else{
      Scroll();
      aqObject.CheckProperty(Get_RelationshipsGrid_ChMargin(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",33,language));}
    aqObject.CheckProperty(Get_RelationshipsGrid_ChCommunication(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",32,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",34,language));   
    aqObject.CheckProperty(Get_RelationshipsGrid_ChMargin(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",8,language));
    aqObject.CheckProperty(Get_RelationshipsGrid_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",9,language));
    // Il faut ajouter le point de vérification pour Billable pour la US
    if( client == "US"){
    aqObject.CheckProperty(Get_RelationshipsGrid_ChBillable(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",10,language));
    }
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Restore() 
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
    Get_RelationshipsGrid_ChCurrency().ClickR();
    Get_RelationshipsGrid_ChCurrency().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
    Log.Message(count);
    if (Get_GridHeader_ContextualMenu_AddColumn_Profiles().Exists)    //Ajouté par A.A
        count = count - 1;
    Log.Message(count);
    for(i=1; i<=count; i++){
//    while (Get_GridHeader_ContextualMenu_AddColumn().IsEnabled){
     Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click(); 
//      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
    Get_RelationshipsGrid_ChCurrency().ClickR();
    }  
}
 function test(){
   
 var ControlWidth=Get_RelationshipsClientsAccountsGrid().get_ActualWidth()
       var ControlHeight=Get_RelationshipsClientsAccountsGrid().get_ActualHeight()
       Get_RelationshipsClientsAccountsGrid().Click(ControlWidth-40, ControlHeight-3); 
 } 