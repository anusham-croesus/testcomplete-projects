//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CommonCheckpoints

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800217. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Rechercher la position FID285. 
Afficher la fenêtre «Orders Module » en cliquant sur le MenuBar-OrderEntryModule-CreateBuyOrder
Vérifier le texte et la présence des contrôles */

function Survol_Por_Menubar_CreateBuyOrder_Funds()
{
    // Les variables utilisées dans les points de vérifications 
    var type="mutualFunds";
    var module="portefeuille";
    var order="buy";
    var calledFrom = "CreateABuyOrder";
    var orderStatus = "Creation";
    
   
      Login(vServerPortefeuille, userName , psw ,language);
      Get_ModulesBar_BtnClients().Click()
  
      if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800217")}
      else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
      
      //Get_RelationshipsClientsAccountsGrid().Find("Value","800217",1000).Click();

      //maillage vers le module portefeuille 
      Get_MenuBar_Modules().OpenMenu();
      Get_MenuBar_Modules_Portfolio().OpenMenu();
      Get_MenuBar_Modules_Portfolio_DragSelection().Click();
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
      
       //Vérifier que le module portefeuille sélectionné 
      aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);  
  
      if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){ Search_Position("FID285")}
      else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}  
      
      //Afficher la fenêtre «Orders Module » en cliquant sur le MenuBar-OrderEntryModule-CreateBuyOrder
      Get_MenuBar_Edit().OpenMenu();
      Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
      Get_MenuBar_Edit_OrderEntryModule_CreateABuyOrder().Click();
  
      Check_Properties_CreateOrder_DifType(language, type, module, order, calledFrom, orderStatus);// la fonction est dans CommonCheckpoints
    
      Get_WinOrderDetail_BtnCancel().Keys("[Esc]");
   
      Close_Croesus_MenuBar();
    
}
