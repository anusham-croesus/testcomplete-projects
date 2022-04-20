//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA



/**
    Description : Valider que le critère ne s’affiche pas automatiquement si la pref =NON, module Ordres
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5749
    Analyste d'assurance qualité : Marina Gasin
    Analyste d'automatisation : Asma Alaoui
    Version:ref90-10-Fm-6--V9
*/

function CR2050_5749_ORD_ValidateNotDisplayCriteriaWhenPrefYes()
{
    try{
      
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5749","CR2050");
        var test=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "NomCritère_5749", language+client);
        var open= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "Croes_5749_Statut", language+client);       
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "AccountNo_5749", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "Quantity_5749", language+client);
        var security= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "Security_5749", language+client);
        var financialInstrument=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "FinancialInstrumentStock_5749", language+client);
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "OrderType_5749", language+client);
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "SecuritySymbol_5749", language+client);
        
        //Format date
         if (language == "french")
            var dateFormat = "%Y/%m/%d";
         else
            var dateFormat = "%m/%d/%Y";
        
        Activate_Inactivate_Pref("KEYNEJ","PREF_FIDESSA_SESSION_TIME","0:00|0:00",vServerAccounts);
        Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_OPEN_TIME","STOCKS>0:0:0|BONDS>0:0:0|FUNDS>0:0:0",vServerAccounts);
        Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>23:59:59|BONDS>23:59:59|FUNDS>23:59:59",vServerAccounts);
        Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_SKIP_HOLIDAY_CHECK","YES",vServerAccounts);   
  
        Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
        RestartServices(vServerAccounts);
        
        //Se connecter avec KEYNEJ
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);       
        
        //Accès au module Ordres
        Get_ModulesBar_BtnOrders().Click();  
        
        //Creation d'un ordre qui a le status ouvert --- EM : Étape ajoutée pour qu'il soit tjrs dans la BD qui a le status ouvert
//        CreateEditStocksOrder(account,quantity,security)
        CreateEditStocksOrder(account,quantity,securitySymbol)
        Log.Message("Valider l'existance de l'ordre créé dans l'accumulateur");
        if(CheckPresenceOrderInAccumulator(account,quantity,securitySymbol,financialInstrument,orderType)){
            Log.Message("Vérifier et soumettre l'ordre crée");
            VerifySubmitOrder(account);
        }         
        else
            Log.Error("Un ordre créé ne s'affiché pas en bas dans Accumulateur")
        
        Log.Message("sélectionner ordre symbole = "+security+"/ cliquer sur Consulter.../Approuver ==> Valider Status = "+open) 
        ApproveCheckOrderStatus(securitySymbol, open, dateFormat);
    
        //Cliquer sur le bouton "Gérer les critères de recherche"
        Get_Toolbar_BtnManageSearchCriteria().Click();     
        AddCriteria(test);
        
        //Valider bouton "Réafficher tout et conserver les crochets"
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsChecked",cmpEqual, true);
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"Exists",cmpEqual, true);
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"VisibleOnScreen",cmpEqual, true);
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsVisible",cmpEqual, true);
        
        //Valider que les ordres sélectionnés ayant le statut  = Ouvert sont affichés avec un crochet rouge.
        ValidateMatchesCriteriaOrdres(open);
        
        //Fermer l'application  
        Terminate_CroesusProcess();
        
        //Se connecter avec KEYNEJ
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        
        //Accès au module Ordres
        Get_ModulesBar_BtnOrders().Click();  
        
        //Aucune position n’est sélectionnée avec de crochet rouge
        ValidateNoMatchesCriteriaOrdres();
     }
  catch(e) 
    {
       Log.Error("Exception: " + e.message, VarToStr(e.stack));
       Terminate_CroesusProcess();
       Delete_FilterCriterion(test,vServerAccounts)
       Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
       RestartServices(vServerAccounts); 
       Terminate_CroesusProcess();
      
    }
    
  finally
    {   
        
      Delete_FilterCriterion(test,vServerAccounts)//Supprimer le criterion de BD      
      Terminate_CroesusProcess(); //Fermer Croesus
      Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
      
       Log.Message("Supprimer les ordres qui ont été créés aujourd'hui")
       //Execute_SQLQuery("delete b_gdo_order where blotter_date = convert(varchar, getdate(), 101)", vServerOrders);
       Execute_SQLQuery("delete B_GDO_BLOCK_ACCOUNTS from B_GDO_ORDER o join B_GDO_BLOCK_ACCOUNTS b on o.GDODER_ID = b.GDODER_ID where o. TSTAMP_CREATE  >= convert(varchar, getdate(), 101)",vServerAccounts);
       Execute_SQLQuery("delete B_GDO_Fill from B_GDO_ORDER o join B_GDO_Fill f on o.wire_number = f.wire_number where o. TSTAMP_CREATE  >= convert(varchar, getdate(), 101)",vServerAccounts);
       Execute_SQLQuery("delete B_GDO_ORDER where  TSTAMP_CREATE  >= convert(varchar, getdate(), 101)",vServerAccounts);
      
      RestartServices(vServerAccounts); 
      Terminate_CroesusProcess();
    }    
}

function CreateEditStocksOrder(account,quantity,security)
 {
   Get_Toolbar_BtnCreateABuyOrder().Click();        
    //Selectioner 'Stoks'
    Get_WinFinancialInstrumentSelector_RdoStocks().Click();
    Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
    Get_WinFinancialInstrumentSelector_BtnOK().Click();
    
    //Creation d'ordre 
    if (Trim(VarToStr(account))!== ""){     
      Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
    }
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    
    if (Trim(VarToStr(quantity))!== ""){  
      Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
    }
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
    
    if (Trim(VarToStr(security))!== ""){ 
      Get_WinOrderDetail_GrpSecurity_CmbTypePicker().set_SelectedIndex(0);
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(security);
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
      if(Get_SubMenus().Exists){
        Aliases.CroesusApp.subMenus.Find("Value",security,10).DblClick();
      }
    }    
    Get_WinOrderDetail_BtnSave().Click();
 }

//ajouter un critère de recherche
function AddCriteria(test)
{
          
    //sur la fenêtre Critères de recheche cliquer sur Ajouter
    Get_WinSearchCriteriaManager_BtnAdd().Click(); 
      
    //Saisir le nom 
    Get_WinAddSearchCriterion_TxtName().Keys(test);
    
    //Sur "Definition" modifier <Verbe> à "ayant"
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Delay(500)
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    
    //Sur <Champ> choisir "Informatif" ensuite "état" piur la version FM et "statut" pour les versions antérieurs
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemTypeStatus().Click();
    
    //Sur <Opérateur> choisir "égal(e) à" 
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
    
    //choisir la valeur "Ouvert"
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();  
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemOpen().Click();   
    
    //Sur <Suivant> choisir le point " . "
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    
    // Cliquer sur "Sauvgarder et actualiser
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
} 


function ValidateMatchesCriteriaOrdres(open) 
{    
    var count =  Get_OrderGrid().RecordListControl.Items.Count;
 
  for(var i = 0; i < count; i++)
    {  
      
    
    var statut=  Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Status;
    var valueMatchesCriterion=Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.MatchesCriterion;
    
           
        if(valueMatchesCriterion == true && statut == open)
                            
            Log.Checkpoint("Le critère de recherche "+statut+" est respecté" )
          else 
            Log.Error("La ligne "+i+" ne respecte pas le critère de recheche "+statut+" attendu")             
    }   
 
}

function ValidateNoMatchesCriteriaOrdres() 
{    
    var count =  Get_OrderGrid().RecordListControl.Items.Count;
 
  for(var i = 0; i < count; i++)
      {  
       var valueMatchesCriterion=Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.MatchesCriterion;
    
           
        if(valueMatchesCriterion == true)
        
                       
            Log.Error("La ligne "+i+" ne respecte pas l'affichage attendu")
          else 
            Log.Checkpoint("Aucune position n'est sélectionnée" )           
    }   
}