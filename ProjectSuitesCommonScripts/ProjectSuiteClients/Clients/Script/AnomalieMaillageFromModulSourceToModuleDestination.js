//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module client
                      Sélectionner un client 
                      Mailler ce client vers tous les modules avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )

    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromClientToAllModules()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Se connecter avec COPERN
        Login(vServerClients, userNameCOPERN, passwordCOPERN, language);
     
        //Mailler un seul client vers tous les modules avec les 3 façcons
        /*Dans le module client
        Sélectionner une client 
        */
        /* 1-Mailler un client vers tous les modules avec l'option drag*/
        
       //Mailler vers le module compte
        Log.Message("Mailler un seul client vers tous les modules avec les 3 options")
        Log.Message("Mailler vers le module compte")
        //L'option drag Drop
         Log.Message("Mailler vers le module compte avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(),"dragDrop","SelectOnItem",Get_RelationshipsClientsAccountsBar())
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module compte avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(),"clickRightFunction","SelectOnItem",Get_RelationshipsClientsAccountsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module compte avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(),"menuModule","SelectOnItem",Get_RelationshipsClientsAccountsBar())
        
        
        
    
        //Mailler vers le module Relation
        Log.Message("Mailler vers le module relation")
        //L'option drag Drop
         Log.Message("Mailler vers le module relation avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),"dragDrop","SelectOnItem",Get_RelationshipsClientsAccountsBar())
        
          //L'option click right ensuite on choisis fonctions
         Log.Message("Mailler vers le module relation avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),"clickRightFunction","SelectOnItem",Get_RelationshipsClientsAccountsBar())
        
        //L'option menu module
         Log.Message("Mailler vers le module relation avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),"menuModule","SelectOnItem",Get_RelationshipsClientsAccountsBar())
        
        
        //Mailler vers le module transaction
        Log.Message("Mailler vers le module transaction")
       
        
       //L'option drag Drop
         Log.Message("Mailler vers le module transaction avec l'option drag drop")
         MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),"dragDrop","SelectOnItem",Get_TransactionsBar())
        
          //L'option click right ensuite on choisis fonctions
         Log.Message("Mailler vers le module transaction avec l'option click right ensuite on choisis fonctions")
         MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),"clickRightFunction","SelectOnItem",Get_TransactionsBar())
        
        //L'option menu module
         Log.Message("Mailler vers le module transaction avec l'option menu module ")
         MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),"menuModule","SelectOnItem",Get_TransactionsBar())
        
        
        //Mailler vers le module Modèles
         Log.Message("Mailler vers le module Modèles")
         
         //L'option drag Drop
         Log.Message("Mailler vers le module Modèles avec l'option drag drop")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnModels(),"dragDrop","SelectOnItem",Get_ModelsBar())
        
          //L'option click right ensuite on choisis fonctions
         Log.Message("Mailler vers le module Modèles avec l'option click right ensuite on choisis fonctions")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnModels(),"clickRightFunction","SelectOnItem",Get_ModelsBar())
        
        //L'option menu module
         Log.Message("Mailler vers le module Modèles avec l'option menu module")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnModels(),"menuModule","SelectOnItem",Get_ModelsBar())        
        
       
        //Mailler vers le module Portefeuille
      
        
      Log.Message("Mailler vers le module Portefeuille");
      
         
         //L'option drag Drop
         Log.Message("Mailler vers le module portefeuille avec l'option drag drop")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnPortfolio(),"dragDrop","SelectOnItem")
        
          //L'option click right ensuite on choisis fonctions
         Log.Message("Mailler vers le module portefeuille avec l'option click right ensuite on choisis fonctions")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnPortfolio(),"clickRightFunction","SelectOnItem")
        
        //L'option menu module
         Log.Message("Mailler vers le module portefeuille avec l'option menu module")
         MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnPortfolio(),"menuModule","SelectOnItem")
         
         
          
        //Mailler vers le module Titres
        Log.Message("Mailler vers le module titre")
        
         //L'option drag Drop
          Log.Message("Mailler vers le module portefeuille avec l'option drag drop")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),"dragDrop","SelectOnItem",Get_SecuritiesBar())
        
          //L'option click right ensuite on choisis fonctions
          Log.Message("Mailler vers le module portefeuille avec l'option click right ensuite on choisis fonctions")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),"clickRightFunction","SelectOnItem",Get_SecuritiesBar())
        
          //L'option menu module
          Log.Message("Mailler vers le module portefeuille avec l'option menu module")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),"menuModule","SelectOnItem",Get_SecuritiesBar())
         
        
         
        //Mailler plusieurs clients vers tous les modules avec les 3 façons*/
        Log.Message("Mailler  20 clients vers tous les modules avec les 3 options")
        //"SelectManyItem"
        
        
          Log.Message("Mailler vers le module compte")
        //L'option drag Drop
         Log.Message("Mailler vers le module compte avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(),"dragDrop","SelectManyItem",Get_RelationshipsClientsAccountsBar())
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module compte avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(),"clickRightFunction","SelectManyItem",Get_RelationshipsClientsAccountsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module compte avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(),"menuModule","SelectManyItem",Get_RelationshipsClientsAccountsBar())
        
        
        
    
        //Mailler vers le module Relation
        Log.Message("Mailler vers le module relation")
        //L'option drag Drop
         Log.Message("Mailler vers le module relation avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),"dragDrop","SelectManyItem",Get_RelationshipsClientsAccountsBar())
        
          //L'option click right ensuite on choisis fonctions
         Log.Message("Mailler vers le module relation avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),"clickRightFunction","SelectManyItem",Get_RelationshipsClientsAccountsBar())
        
        //L'option menu module
         Log.Message("Mailler vers le module relation avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),"menuModule","SelectManyItem",Get_RelationshipsClientsAccountsBar())
        
        
        //Mailler vers le module transaction
        Log.Message("Mailler vers le module transaction")
       
        
       //L'option drag Drop
         Log.Message("Mailler vers le module transaction avec l'option drag drop")
         MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),"dragDrop","SelectManyItem",Get_TransactionsBar())
        
          //L'option click right ensuite on choisis fonctions
         Log.Message("Mailler vers le module transaction avec l'option click right ensuite on choisis fonctions")
         MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),"clickRightFunction","SelectManyItem",Get_TransactionsBar())
        
        //L'option menu module
         Log.Message("Mailler vers le module transaction avec l'option menu module ")
         MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),"menuModule","SelectManyItem",Get_TransactionsBar())
        
        
        //Mailler vers le module Modèles
         Log.Message("Mailler vers le module Modèles")
         
         //L'option drag Drop
         Log.Message("Mailler vers le module Modèles avec l'option drag drop")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnModels(),"dragDrop","SelectManyItem",Get_ModelsBar())
        
          //L'option click right ensuite on choisis fonctions
         Log.Message("Mailler vers le module Modèles avec l'option click right ensuite on choisis fonctions")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnModels(),"clickRightFunction","SelectManyItem",Get_ModelsBar())
        
        //L'option menu module
         Log.Message("Mailler vers le module Modèles avec l'option menu module")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnModels(),"menuModule","SelectManyItem",Get_ModelsBar())        
        
       
        //Mailler vers le module Portefeuille
      
        
      Log.Message("Mailler vers le module Portefeuille");
      
         
         //L'option drag Drop
         Log.Message("Mailler vers le module portefeuille avec l'option drag drop")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnPortfolio(),"dragDrop","SelectManyItem")
        
          //L'option click right ensuite on choisis fonctions
         Log.Message("Mailler vers le module portefeuille avec l'option click right ensuite on choisis fonctions")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnPortfolio(),"clickRightFunction","SelectManyItem")
        
        //L'option menu module
         Log.Message("Mailler vers le module portefeuille avec l'option menu module")
         MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnPortfolio(),"menuModule","SelectManyItem")
         
         
          
        //Mailler vers le module Titres
        Log.Message("Mailler vers le module titre")
        
         //L'option drag Drop
          Log.Message("Mailler vers le module portefeuille avec l'option drag drop")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),"dragDrop","SelectManyItem",Get_SecuritiesBar())
        
          //L'option click right ensuite on choisis fonctions
          Log.Message("Mailler vers le module portefeuille avec l'option click right ensuite on choisis fonctions")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),"clickRightFunction","SelectManyItem",Get_SecuritiesBar())
        
          //L'option menu module
          Log.Message("Mailler vers le module portefeuille avec l'option menu module")
          MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),"menuModule","SelectManyItem",Get_SecuritiesBar())
         
        
        
        
        
        
    
        
        
        Get_ModelsGrid

        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}


function MaillageFromOneModuleToTargetModuleAllOption(functionGetBtnModuleSource,functionGetBtnModuleDestination, optionMaillage,OptionSelect,functionGetGrillModulSource,functionGetBarTargetModule)
{
  
      functionGetBtnModuleSource.Click();
       var BarTargetMaillage=functionGetBtnModuleDestination.Pad.Text.OleValue;
      
      /*********************Début de l'option de sélection****************************************************************************************************************/
       if(OptionSelect == "SelectOnItem")
       { 
       if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnModels().Pad.Text.OleValue )//Modèles
       {
         
        var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.AccountNumber.OleValue;
        functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
        
        
       }
         if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnTransactions().Pad.Text.OleValue )//transactions
         {
             var FirstLigne=  functionGetGrillModulSource.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WPFObject("BrowserCellTemplateSimple", "", 1).Text.OleValue
             functionGetGrillModulSource.FindChild("Text",FirstLigne,10).Click() ;
           
           
         }
         if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnAccounts().Pad.Text.OleValue )//compte
       {
        
         var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.AccountNumber.OleValue;
        functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
       }
       
         if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnClients().Pad.Text.OleValue )//client
       {
         
        var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.ClientNumber.OleValue;
        functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
       
        
       }
         if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnRelationships().Pad.Text.OleValue )//relations
       {
         
         var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.LinkNumber.OleValue;
        functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
       
       }
       
         if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue )//portefeuille
       {
         var FirstLigne=functionGetGrillModulSource.WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AccountNumber.OleValue
        functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;  

       }
         if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnSecurities().Pad.Text.OleValue )//Titres
       {
         
         var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.SecuFirm.OleValue;
        functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;  
    
       }
       
        
        }
        
        if(OptionSelect == "SelectManyItem")
        {
          
         if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnModels().Pad.Text.OleValue )//Modèles
         {
             var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.AccountNumber.OleValue;
          functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
          Sys.Desktop.KeyDown(0x10);
          var LastLigne=functionGetGrillModulSource.RecordListControl.Items.Item(19).DataItem.AccountNumber.OleValue;
          functionGetGrillModulSource.FindChild("Value",LastLigne,10).Click() ;
          Sys.Desktop.KeyUp(0x10);
         }
        
          if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnTransactions().Pad.Text.OleValue )//transactions
          {
             var FirstLigne=  functionGetGrillModulSource.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WPFObject("BrowserCellTemplateSimple", "", 1).Text.OleValue
          functionGetGrillModulSource.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).Click() 
          //WaitProperty("VisibleOnScreen", true, 30000)
          
          Sys.Desktop.KeyDown(0x10);
         
          functionGetGrillModulSource.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "20"], 10).Click()
     
          Sys.Desktop.KeyUp(0x10);
          }
          if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnAccounts().Pad.Text.OleValue )//compte
         {
            var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.AccountNumber.OleValue;
          functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
          Sys.Desktop.KeyDown(0x10);
          var LastLigne=functionGetGrillModulSource.RecordListControl.Items.Item(19).DataItem.AccountNumber.OleValue;
          functionGetGrillModulSource.FindChild("Value",LastLigne,10).Click() ;
          Sys.Desktop.KeyUp(0x10);
         }
         
         if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnClients().Pad.Text.OleValue )//client
         {
           var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.ClientNumber.OleValue;
          functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
          Sys.Desktop.KeyDown(0x10);
          var LastLigne=functionGetGrillModulSource.RecordListControl.Items.Item(19).DataItem.ClientNumber.OleValue;
          functionGetGrillModulSource.FindChild("Value",LastLigne,10).Click() ;
          Sys.Desktop.KeyUp(0x10);
         }
        if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnRelationships().Pad.Text.OleValue )//relations
         {
           var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.LinkNumber.OleValue;
          functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
          Sys.Desktop.KeyDown(0x10);
          var LastLigne=functionGetGrillModulSource.RecordListControl.Items.Item(19).DataItem.LinkNumber.OleValue;
          functionGetGrillModulSource.FindChild("Value",LastLigne,10).Click() ;
          Sys.Desktop.KeyUp(0x10);
         }
         if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue )//portefeuille
         {
         var FirstLigne=functionGetGrillModulSource.WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AccountNumber.OleValue
          functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
          Sys.Desktop.KeyDown(0x10);
          var LastLigne=functionGetGrillModulSource.WPFObject("RecordListControl", "", 1).Items.Item(19).DataItem.AccountNumber.OleValue
          functionGetGrillModulSource.FindChild("Value",LastLigne,10).Click() ;
          Sys.Desktop.KeyUp(0x10);
         }
         
          if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnSecurities().Pad.Text.OleValue )//Titres
         {
          var FirstLigne=functionGetGrillModulSource.RecordListControl.Items.Item(0).DataItem.SecuFirm.OleValue;
          functionGetGrillModulSource.FindChild("Value",FirstLigne,10).Click() ;
          Sys.Desktop.KeyDown(0x10);
          var LastLigne=functionGetGrillModulSource.RecordListControl.Items.Item(19).DataItem.SecuFirm.OleValue;
          functionGetGrillModulSource.FindChild("Value",LastLigne,10).Click() ;
          Sys.Desktop.KeyUp(0x10);
         }
     
        }
         /*********************Fin de l'option de sélection****************************************************************************************************************/
         
         /************************************************Début de l'option de maillage*************************************************************************************/
        if(optionMaillage == "dragDrop")
        {
          
          if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnTransactions().Pad.Text.OleValue )//transactions
          {
            Drag(functionGetGrillModulSource.FindChild("Text",FirstLigne,10), functionGetBtnModuleDestination)
          }
          else
          {
        Drag(functionGetGrillModulSource.FindChild("Value",FirstLigne,10), functionGetBtnModuleDestination)
          }
        }
        if(optionMaillage == "clickRightFunction")
        {
         if(functionGetBtnModuleSource.Pad.Text.OleValue ==Get_ModulesBar_BtnTransactions().Pad.Text.OleValue )//transactions
          {
            functionGetGrillModulSource.FindChild("Text",FirstLigne,10).ClickR() ;
            functionGetGrillModulSource.FindChild("Text",FirstLigne,10).ClickR() ;
          }
          
          else{
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).ClickR() ;
            functionGetGrillModulSource.FindChild("Value",FirstLigne,10).ClickR() ;
            }
        
         
        if((Get_ModulesBar_BtnAccounts().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue )|| (Get_ModulesBar_BtnClients().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue )||(Get_ModulesBar_BtnRelationships().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue ))//Comptes ou client ou relations
        {
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
          
               if(BarTargetMaillage == Get_ModulesBar_BtnClients().Pad.Text.OleValue)//client
                {
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Clients().Click()
                }
                
                if(BarTargetMaillage == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue)//compte
                {
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Accounts().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue)//relation
                {
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Relationships().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue)//transaction
                {
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Transactions().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue)//portefeuille
                {
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Portfolio().Click()
                }
                 if(BarTargetMaillage == Get_ModulesBar_BtnModels().Pad.Text.OleValue)//modèle
                {
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Models().Click()
                }
                 if(BarTargetMaillage == Get_ModulesBar_BtnSecurities().Pad.Text.OleValue)//titre
                {
                Get_ClientsAccountsGrid_ContextualMenu_Functions_Security().Click()
                }
                
        }
        /************************************************Modèles*************************************************************/
          if(Get_ModulesBar_BtnModels().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue )
        {
                Get_ModelsGrid_ContextualMenu_Functions().Click();
                if(BarTargetMaillage == Get_ModulesBar_BtnClients().Pad.Text.OleValue)//client
                {
                Get_ModelsGrid_ContextualMenu_Functions_Clients().Click()
                }
                
                if(BarTargetMaillage == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue)//compte
                {
                Get_ModelsGrid_ContextualMenu_Functions_Accounts().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue)//relation
                {
                Get_ModelsGrid_ContextualMenu_Functions_Relationships().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue)//transaction
                {
                Get_ModelsGrid_ContextualMenu_Functions_Transactions().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue)//portefeuille
                {
                Get_ModelsGrid_ContextualMenu_Functions_Positions().Click()
                }
              
         
        }
        
        
        
         /************************************************portefeuille*************************************************************/
           if(Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue )
        {
                Get_PortfolioGrid_ContextualMenu_Functions().Click();
                if(BarTargetMaillage == Get_ModulesBar_BtnClients().Pad.Text.OleValue)//client
                {
                Get_PortfolioGrid_ContextualMenu_Functions_Clients().Click()
                }
                
                if(BarTargetMaillage == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue)//compte
                {
                Get_PortfolioGrid_ContextualMenu_Functions_Accounts().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue)//relation
                {
                Get_PortfolioGrid_ContextualMenu_Functions_Relationships().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue)//transaction
                {
                Get_PortfolioGrid_ContextualMenu_Functions_Transactions().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnModels().Pad.Text.OleValue)//modèles
                {
                Get_PortfolioGrid_ContextualMenu_Functions_Models().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnSecurities().Pad.Text.OleValue)//titre
                {
                Get_PortfolioGrid_ContextualMenu_Functions_Securities().Click()
                }
         
        }
         
         
         
         /**************************************************Titres*****************************************************************/
          
            if(Get_ModulesBar_BtnSecurities().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue )
        {
                Get_SecurityGrid_ContextualMenu_Functions().Click();
                if(BarTargetMaillage == Get_ModulesBar_BtnClients().Pad.Text.OleValue)//client
                {
                Get_SecurityGrid_ContextualMenu_Functions_Clients().Click()
                }
                
                if(BarTargetMaillage == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue)//compte
                {
                Get_SecurityGrid_ContextualMenu_Functions_Accounts().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue)//relation
                {
                Get_SecurityGrid_ContextualMenu_Functions_Relationships().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue)//transaction
                {
                Get_SecurityGrid_ContextualMenu_Functions_Transactions().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnModels().Pad.Text.OleValue)//modèles
                {
                Get_SecurityGrid_ContextualMenu_Functions_Models().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnSecurities().Pad.Text.OleValue)//portefeuille
                {
                Get_SecurityGrid_ContextualMenu_Functions_Portfolio().Click()
                }
         
        }
        /********************************************Transactions****************************************************************/
         

         if(Get_ModulesBar_BtnTransactions().Pad.Text.OleValue == functionGetBtnModuleSource.Pad.Text.OleValue  )//transactions
        {
            var numberOftries=0;  
              while ( numberOftries < 5 && !Get_SubMenus().Exists){
              Get_MainWindow().Keys("[Apps]")
               // Get_Transactions_ContextualMenu_Functions().Click();
                numberOftries++;
              } 
               Get_Transactions_ContextualMenu_Functions().Click();
                if(BarTargetMaillage == Get_ModulesBar_BtnClients().Pad.Text.OleValue)//client
                {
                Get_Transactions_ContextualMenu_Functions_Clients().Click()
                }
                
                if(BarTargetMaillage == Get_ModulesBar_BtnAccounts().Pad.Text.OleValue)//compte
                {
                Get_Transactions_ContextualMenu_Functions_Accounts().Click()
                }
                if(BarTargetMaillage == Get_ModulesBar_BtnModels().Pad.Text.OleValue)//modèle
                {
                Get_Transactions_ContextualMenu_Functions_Models().Click()
                }
       
                  if(BarTargetMaillage == Get_ModulesBar_BtnRelationships().Pad.Text.OleValue)//relation
                {
                Get_Transactions_ContextualMenu_Functions_Relationships().Click()
                }
                
                  if(BarTargetMaillage == Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue)//portefeuille
                {
                Get_Transactions_ContextualMenu_Functions_Portfolio().Click()
                }
               if(BarTargetMaillage == Get_ModulesBar_BtnSecurities().Pad.Text.OleValue)//titre
                {
                Get_Transactions_ContextualMenu_Functions_Securities().Click()
                }
       
        }
        
        
          
        }
        
        if(optionMaillage == "menuModule")
        {
         Get_MenuBar_Modules().Click();
          Get_MenuBar_Modules().DblClick();
         WaitObject(Get_SubMenus(), ["Uid","VisibleOnScreen"], ["CustomizableMenu_8159", true]);  
         
          if(Get_ModulesBar_BtnAccounts().Pad.Text.OleValue == BarTargetMaillage )
        {
            Get_MenuBar_Modules_Accounts().DblClick();
            Get_MenuBar_Modules_Accounts().DblClick();
            WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_e9d6", true]); 
            Get_MenuBar_Modules_Accounts_DragSelection().Click();
            
            
        }
        
        
        
         if(Get_ModulesBar_BtnRelationships().Pad.Text.OleValue == BarTargetMaillage )
        {
           Get_MenuBar_Modules_Relationships().DblClick();
           Get_MenuBar_Modules_Relationships().DblClick();
           WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_2435", true]); 
           Get_MenuBar_Modules_Relationships_DragSelection().DblClick();
           
        }
        
        
         if(Get_ModulesBar_BtnModels().Pad.Text.OleValue == BarTargetMaillage )
        {
          Get_MenuBar_Modules_Models().DblClick();
          Get_MenuBar_Modules_Models().DblClick();
          WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_aba8", true]); 
          Get_MenuBar_Modules_Models_DragSelection().DblClick();
         
        }
        
        
           if(Get_ModulesBar_BtnPortfolio().Pad.Text.OleValue == BarTargetMaillage )
        {
           
           Get_MenuBar_Modules_Portfolio().DblClick();
           Get_MenuBar_Modules_Portfolio().DblClick();
           WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_edd3", true]); 
           Get_MenuBar_Modules_Portfolio_DragSelection().DblClick();
            
        }
        
          if(Get_ModulesBar_BtnTransactions().Pad.Text.OleValue == BarTargetMaillage )
        {
            Get_MenuBar_Modules_Transactions().DblClick();
            Get_MenuBar_Modules_Transactions().DblClick();
            WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_92ff", true]); 
            Get_MenuBar_Modules_Transactions_DragSelection().DblClick();
          
        }
        
          if(Get_ModulesBar_BtnSecurities().Pad.Text.OleValue == BarTargetMaillage )
        {
            Get_MenuBar_Modules_Securities().DblClick();
            Get_MenuBar_Modules_Securities().DblClick();
            WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_088b", true]); 
            Get_MenuBar_Modules_Securities_DragSelection().Click();
           
        }
        if(Get_ModulesBar_BtnClients().Pad.Text.OleValue == BarTargetMaillage )
        {
            Get_MenuBar_Modules_Clients().DblClick();
            Get_MenuBar_Modules_Clients().DblClick();
            WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_0d83", true]); 
            Get_MenuBar_Modules_Clients_DragSelection().Click();
            
            
        }
        
        }
        
        
         /************************************************Fin de l'option de maillage*************************************************************************************/
         
        functionGetBtnModuleDestination.WaitProperty("IsChecked", true, 300000);
     
        Log.Message("la variable BarTargetMaillage est "+BarTargetMaillage);
        
       if(BarTargetMaillage == Get_ModulesBar_BtnTransactions().Pad.Text.OleValue){
       functionGetBarTargetModule=Get_TransactionsPlugin().Find(["ClrClassName", "WPFControlOrdinalNo","VisibleOnScreen"], ["PadHeader", "1",true], 10)
        }
       
         if(functionGetBarTargetModule == undefined)
         {
         functionGetBarTargetModule=  Get_PortfolioBar();
         }
        var x=functionGetBarTargetModule;
      
        aqObject.CheckProperty(functionGetBarTargetModule, "Text", cmpEqual, BarTargetMaillage);

        

  
}

function test123456()
{
//MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnSecurities(),"menuModule","SelectOnItem",Get_Transactions_ListView(),Get_SecuritiesBar())//Mailler transaction avec une seule transaction vers titre
//MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnModels(),"menuModule","SelectOnItem",Get_Transactions_ListView(),Get_ModelsBar())//mailler de transaction une seule transaction vers modèle
//MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnModels(),"menuModule","SelectManyItem",Get_Transactions_ListView(),Get_ModelsBar())//mailler des transactions 20 vers modèle
//MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnRelationships(),"menuModule","SelectManyItem",Get_Transactions_ListView(),Get_RelationshipsClientsAccountsBar())//mailler des transactions 20 vers relations
//MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnRelationships(),"menuModule","SelectOnItem",Get_Transactions_ListView(),Get_RelationshipsClientsAccountsBar())//mailler une transaction vers relations
//MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnClients(),"menuModule","SelectOnItem",Get_Transactions_ListView(),Get_RelationshipsClientsAccountsBar())//mailler une transaction vers client avec l'option module
//MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnClients(),"dragDrop","SelectOnItem",Get_Transactions_ListView(),Get_RelationshipsClientsAccountsBar())//mailler une transaction vers client avec l'option Drag and drop
//MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnClients(),"clickRightFunction","SelectOnItem",Get_Transactions_ListView(),Get_RelationshipsClientsAccountsBar())//mailler une transaction vers client avec l'option click right
//MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnClients(),"clickRightFunction","SelectManyItem",Get_Transactions_ListView(),Get_RelationshipsClientsAccountsBar())//mailler plusieurs transaction vers client avec l'option click right
//MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),Get_ModulesBar_BtnClients(),"clickRightFunction","SelectManyItem",Get_SecurityGrid(),Get_RelationshipsClientsAccountsBar())//Mailler plusieurs titres vers le module client avec l'option click-right
//MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),Get_ModulesBar_BtnClients(),"dragDrop","SelectManyItem",Get_SecurityGrid(),Get_RelationshipsClientsAccountsBar())//Mailler plusieurs titres vers le module client avec l'option drag drop
//MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),Get_ModulesBar_BtnClients(),"menuModule","SelectManyItem",Get_SecurityGrid(),Get_RelationshipsClientsAccountsBar())//Mailler plusieurs titres vers le module client avec l'option module menu
MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnModels(),Get_ModulesBar_BtnClients(),"menuModule","SelectOnItem",Get_ModelsGrid(),Get_RelationshipsClientsAccountsBar())//Mailler un modèle vers le module client avec l'option module menu




}
