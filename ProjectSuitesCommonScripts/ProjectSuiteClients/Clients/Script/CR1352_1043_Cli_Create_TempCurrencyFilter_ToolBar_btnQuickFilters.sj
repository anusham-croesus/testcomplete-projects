//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT DBA


/* Description :Création d'un filtre rapide temporaire dont la valeur est une liste
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1043
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1043_Cli_Create_TempCurrencyFilter_ToolBar_btnQuickFilters()
 {
    
    var client1="800077"
    var client2="800078"
    var client3="101127"
   
    try{
        Login(vServerClients, userName, psw, language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
    
        //Modifier la devise du client  800077 en USD (info client) 
        Execute_SQLQuery("update b_client set CURRENCY='USD' WHERE no_client='"+client1+"'",vServerClients)      
        //Modifier la devise du client  800078 en EUR (info client) 
        Execute_SQLQuery("update b_client set CURRENCY='EUR' WHERE no_client='"+client2+"'",vServerClients)

        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Currency().Click();
        
        //Création d'un filtre
        Get_WinCreateFilter_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
        Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Find("Value","EUR",10).Click(); 
        Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Find("Value","USD",10).Click(10,10,skCtrl); 
//        Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(Get_IndexForCurrencyEUR()).set_IsSelected(true);
//        Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(Get_IndexForCurrencyUSD()).set_IsSelected(true);
        Get_WinCreateFilter_BtnApply().Click();  
   
        //Les points de vérification
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients,"CR1352",24,language));
   
         // Vérifier que le nombre de résultats dans le grid et 2
         if(client == "US"){ aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 3)}
       else {aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 2)}
   
        //Vérification de Tooltip (le test d’Une fenêtre  info bull)
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpMatches, GetData(filePath_Clients,"CR1352",27,language));;
   
        // Cliquer sur le caryon 
        var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-35, 13)
        //Modification   d'un filtre
        Get_WinCreateFilter_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemExcluding().Click();
//        Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(Get_IndexForCurrencyEUR()).set_IsSelected(true);
//        Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(Get_IndexForCurrencyUSD()).set_IsSelected(true);
        Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Find("Value","EUR",10).Click(); 
        Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Find("Value","USD",10).Click(10,10,skCtrl); 
        Get_WinCreateFilter_BtnApply().Click();
    
        //Vérifier que les clients : 800077 et 800078 ne sont pas dans la grille
        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;//Conter les résultats dans le grid
   
        for (i=0; i<= count-1; i++){ 
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.RepresentativeNumber, "OleValue", cmpNotEqual, client1);//YR: Avant RepresentativeId dans CX
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.RepresentativeNumber, "OleValue", cmpNotEqual, client2); //YR: Avant RepresentativeId dans CX
        }   
       
        //Fermer le filtre 
        var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13)
    
       //Remettre la devise Initilale (CAD)  des deux clients 80078 et 800077 
        Execute_SQLQuery("update b_client set CURRENCY='CAD' WHERE no_client='"+client1+"'",vServerClients)  
        Execute_SQLQuery("update b_client set CURRENCY='CAD' WHERE no_client='"+client2+"'",vServerClients)

            if(client == "US")
        {
        //Modifier la devise du client  800078 en EUR (info client) 
        Execute_SQLQuery("update b_client set CURRENCY='CAD' WHERE no_client='"+client3+"'",vServerClients)
         }
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Currency().Click();
        
        //Création d'un filtre
        Get_WinCreateFilter_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
//        Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(Get_IndexForCurrencyEUR()).set_IsSelected(true);
//        Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(Get_IndexForCurrencyUSD()).set_IsSelected(true);
         Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Find("Value","EUR",10).Click(); 
        Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Find("Value","USD",10).Click(10,10,skCtrl); 
        Get_WinCreateFilter_BtnApply().Click();  
      /*  if(client == "US" ){
        
        
         //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        
        Get_Toolbar_BtnQuickFilters_ContextMenu_ClientNo().Click();
        Get_WinCreateFilter_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemIsNotEqualTo().Click();
        Get_WinCreateFilter_TxtValue().SetText("101127");
        Get_WinCreateFilter_BtnApply().Click(); 
        
          
        } */
  //  else{
        //Vérifier le texte de message 
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"CR1352",33,language));
        Get_DlgWarning().Close()//}
   
        Close_Croesus_AltQ();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
    
        //Remettre la devise Initilale (CAD)  des deux clients 80078 et 800077 
        Execute_SQLQuery("update b_client set CURRENCY='CAD' WHERE no_client='"+client1+"'",vServerClients)  
        Execute_SQLQuery("update b_client set CURRENCY='CAD' WHERE no_client='"+client2+"'",vServerClients)
        
          if(client == "US")
        {
        //Modifier la devise du client  800078 en EUR (info client) 
        Execute_SQLQuery("update b_client set CURRENCY='USD' WHERE no_client='"+client3+"'",vServerClients)
         }
    }
   }
 