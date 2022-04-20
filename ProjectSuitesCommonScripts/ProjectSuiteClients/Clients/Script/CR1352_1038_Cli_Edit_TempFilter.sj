//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : Créer un filter temporaire et le modifier par la suite 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1038
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1038_Cli_Edit_TempFilter()
 {
    var filtre ="BD88";
    var modifiedFiltre = "0";
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
       
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_IACode().Click();
    
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
    Get_WinCreateFilter_TxtValue().Keys(filtre);
    Get_WinCreateFilter_BtnApply().Click();    
    
    //Les points de vérification : le texte de filtre
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients,"CR1352",16,language));
    
    // Cliquer sur le crayon     
    var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-35, 13)
       
   //Modifier les champs opérateur et valeur, Opérateur: débutant par , Valeur : 0
    Get_WinCreateFilter_TxtValue().Clear();
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemStartingWith().Click();
    Get_WinCreateFilter_TxtValue().Keys(modifiedFiltre);
    Get_WinCreateFilter_BtnApply().Click();  
    
    if(client=="RJ" || client == "US" || client == "TD" || client == "CIBC" ){
      Get_DlgWarning().Close(); //Fermer le message,car le filtrer ne retourne aucune donnée
      Log.Message("Jira CROES-8034");
    }  
    
    //Les points de vérification: le texte de filtre
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients,"CR1352",17,language));
    
    if (client == "BNC"  ){
       //Les points de vérification : Vérifier que dans le gris, il y a seulement des clients avec le Code de CP débutant par 0
       var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count; //Conter les résultats dans le grid 
   
       for (i=0; i<= count-1; i++){ 
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.RepresentativeNumber, "OleValue", cmpStartsWith, modifiedFiltre); //YR: Avant RepresentativeId dans CX
       } 
     
       //Vérifier le nombre de clients dans la grille et le comparer avec le nombre de clients dans la fenêtre sommation    
       Compare_SumGrid_clientNumber() 
    }
   
   if(client=="RJ" || client == "US" || client == "TD" || client == "CIBC"){
     Compare_SumGrid_clientNumber_WithExternalClient()
   }
   
   Get_MainWindow().SetFocus();
   Close_Croesus_MenuBar();
 }

 // //Vérifier le nombre de clients dans la grille et le compare avec le nombre de clients dans la fenêtre sommation   
 function Compare_SumGrid_clientNumber()
 { 
   //Conter les résultats dans le grid 
   var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
   
   //Cliquer sur Sommation
   Get_Toolbar_BtnSum().Click()
   
   //Les points de vérification : Vérifier que le nombre de résultats dans le gride corresponde au nombre des clients dans la fenêtre sommation 
    if(client == "US" ){
   // if(filtre == "17151.61"){
     // aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, count);
   // } 
   // else{
   aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, count);}//}
    if(client == "TD" ){
    if(count == "27" ){
      aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, count-1);
    } 
    else{
    aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, count);}}
   else { if(client == "RJ" || client == "VMD" || client == "CIBC"){
                aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, count);
                            }
          else aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, count);}

   //Fermer la fenêtre sommation 
   Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
 }

  function Compare_SumGrid_clientNumber_WithExternalClient()
 { 
   //Conter les résultats dans le grid 
   var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
   
   //Cliquer sur Sommation
   Get_Toolbar_BtnSum().Click()
   if(client == "TD" ){
     if(count == 60){
      //Les points de vérification : Vérifier que le nombre de résultats dans le gride corresponde au nombre des clients dans la fenêtre sommation 
      aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, count-5) // Dans la BD de RJ il y a un compte externe, mais dans la fenêtre sommation on peut voir seulement des clients réels 
    }
    else{
      aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, count)}
   } 
   else{
   if(count==0){
     if(client == "RJ" || client == "CIBC"){
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, count);}
   
      //Les points de vérification : Vérifier que le nombre de résultats dans le gride corresponde au nombre des clients dans la fenêtre sommation  
      else aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, count) // Dans la BD de RJ il y a un compte externe, mais dans la fenêtre sommation on peut voir seulement des clients réels 
    }
   else{
       if(client == "RJ" || client == "CIBC"){
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, count-1);
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, count-1);        
        }
//       if(client == "CIBC"){Log.Message(count)
//              aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, count);}
      else aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, count-1)      
    }}

   //Fermer la fenêtre sommation 
   Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
 }
 
 
 