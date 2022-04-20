//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.  
vérifier le texte des en-têtes dans la partie "Log Grid". */

function Survol_Ord_Log_Grid()
{
  Login(vServerOrders, userName , psw ,language);
  Get_ModulesBar_BtnOrders().Click()
  
  Check_Properties(language)
          
  Close_Croesus_MenuBar();
}

//Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties(language)
{
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize() 
        
    aqObject.CheckProperty(Get_OrderLogGrid_ChSupplierNo(), "Content", cmpEqual, GetData(filePath_Orders,"Order_Log_Grid",2,language));
    aqObject.CheckProperty(Get_OrderLogGrid_ChOrderNo(), "Content", cmpEqual, GetData(filePath_Orders,"Order_Log_Grid",3,language));
    aqObject.CheckProperty(Get_OrderLogGrid_ChStatus(), "Content", cmpEqual, GetData(filePath_Orders,"Order_Log_Grid",4,language));
    aqObject.CheckProperty(Get_OrderLogGrid_ChUser(), "Content", cmpEqual, GetData(filePath_Orders,"Order_Log_Grid",5,language));
    
    //cliquer sur scrollbar pour faire l'entête de colonne visible
    var ControlWidth=Get_OrderLogGrid().get_ActualWidth()
    var ControlHeight=Get_OrderLogGrid().get_ActualHeight()
    //for (i=1; i<=28; i++) { Get_SecurityGrid().Click(ControlWidth-20, ControlHeight-5)} 
    Get_OrderLogGrid().Click(ControlWidth-40, ControlHeight-5)
    
    aqObject.CheckProperty(Get_OrderLogGrid_ChDate(), "Content", cmpEqual, GetData(filePath_Orders,"Order_Log_Grid",6,language));
    aqObject.CheckProperty(Get_OrderLogGrid_ChTime(), "Content", cmpEqual, GetData(filePath_Orders,"Order_Log_Grid",7,language));
    aqObject.CheckProperty(Get_OrderLogGrid_ChMessage(), "Content", cmpEqual, GetData(filePath_Orders,"Order_Log_Grid",8,language));
    //scroll
    Get_OrderLogGrid().Click(ControlWidth-40, ControlHeight-5)
    aqObject.CheckProperty(Get_OrderLogGrid_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Orders,"Order_Log_Grid",9,language));
    aqObject.CheckProperty(Get_OrderLogGrid_ChSecurity(), "Content", cmpEqual, GetData(filePath_Orders,"Order_Log_Grid",10,language));
  
}