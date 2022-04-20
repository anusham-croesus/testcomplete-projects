﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Transactions" en cliquant sur BarModules-btnTitre.Rechercher le titre 506391. Afficher la fenêtre «Orders Module » en cliquant sur le bouton Menubar_CreateSellOrder
Selectioner le bouton radio "Stocks". Vérifier le texte et la présence des contrôles */

function Survol_Tra_Menubar_CreateSellOrder()
{
    // Les variables utilisées dans les points de vérifications 
    var type="stocks";
    var module="portefeuille"; //Réutilisation des points de vérifications de module  portefeuille car c'est la même fenêtre    
    var order="sell";
    var calledFrom = "CreateASellOrder";
    var orderStatus = "Creation";
    
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
    {
      Login(vServerTransactions, userName , psw ,language);
      Get_ModulesBar_BtnTransactions().Click();      
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
      WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
      Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);  
      
      //Afficher la fenêtre «Orders Module » en cliquant sur le bouton Menubar_CreateSellOrder    
      Get_MenuBar_Edit().OpenMenu();
      Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
      Get_MenuBar_Edit_OrderEntryModule_CreateASellOrder().Click();
      
      //Les points de vérification
      Check_Properties_CreateOrder_DifType(language, type, module, order, calledFrom, orderStatus);// la fonction est dans CommonCheckpoints
    
      //La fermeture de la fenêtre «Orders Module »
      Get_WinOrderDetail_BtnCancel().Click();
   
      Close_Croesus_MenuBar();
    }
}