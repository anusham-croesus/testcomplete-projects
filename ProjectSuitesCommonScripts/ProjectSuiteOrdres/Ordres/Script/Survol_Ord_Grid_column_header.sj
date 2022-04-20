//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders. Afficher tous les en-têtes des colonnes dans une table (grid) en appelant le menu contextuel (Clique droite), 
vérifier le texte des en-têtes. Par la suite remettre la configuration par défaut */

function Survol_Ord_Grid_column_header()
{
    try {
        Login(vServerOrders, userName , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, 30000);
        
        Check_Properties(language);
        
        Close_Croesus_MenuBar();
        SetAutoTimeOut();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation_BtnYes().Click();
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
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize() 
    
    Get_OrderGrid_ChStatus().ClickR()
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    ReduceColumnsHeadersWidthToMaxValue();
    
    aqObject.CheckProperty(Get_OrderGrid_ChStatus(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",2,language));
    aqObject.CheckProperty(Get_OrderGrid_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",3,language));
    aqObject.CheckProperty(Get_OrderGrid_ChAccountName(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",4,language));
    aqObject.CheckProperty(Get_OrderGrid_ChCfoCxl(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",5,language));
    aqObject.CheckProperty(Get_OrderGrid_ChType(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",6,language));
    aqObject.CheckProperty(Get_OrderGrid_ChTypeColor(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",7,language));
    aqObject.CheckProperty(Get_OrderGrid_ChQuantity(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",8,language));
    aqObject.CheckProperty(Get_OrderGrid_ChSymbol(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",9,language));
    aqObject.CheckProperty(Get_OrderGrid_ChDescription(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",10,language));
    aqObject.CheckProperty(Get_OrderGrid_ChPrice(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",11,language));
    aqObject.CheckProperty(Get_OrderGrid_ChGoodTill(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",12,language));
    aqObject.CheckProperty(Get_OrderGrid_ChExecutedQty(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",13,language));    
    aqObject.CheckProperty(Get_OrderGrid_ChExecutedPrice(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",14,language));
    aqObject.CheckProperty(Get_OrderGrid_ChMarket(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",15,language));
    Scroll();
    aqObject.CheckProperty(Get_OrderGrid_ChLastModification(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",16,language));
    aqObject.CheckProperty(Get_OrderGrid_ChExecutionDate(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",17,language));
    aqObject.CheckProperty(Get_OrderGrid_ChIACode(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",18,language));
    aqObject.CheckProperty(Get_OrderGrid_ChSupplierNo(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",19,language));
    aqObject.CheckProperty(Get_OrderGrid_ChAlternativeOrderNo(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",20,language));
    aqObject.CheckProperty(Get_OrderGrid_ChSource(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",21,language));
    ScrollBack();
        
    //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
    Get_OrderGrid_ChStatus().ClickR()
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 12);//la collone Pro
    
    
    Get_OrderGrid_ChStatus().ClickR()
    while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
    {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_OrderGrid_ChStatus().ClickR()
    }  
    ReduceColumnsHeadersWidthToMaxValue();
    
    aqObject.CheckProperty(Get_OrderGrid_ChStatus(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",2,language));
    aqObject.CheckProperty(Get_OrderGrid_ChSupplier(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",22,language));
    aqObject.CheckProperty(Get_OrderGrid_ChSettlementDate(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",23,language));
    aqObject.CheckProperty(Get_OrderGrid_ChSecurity(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",24,language));
    aqObject.CheckProperty(Get_OrderGrid_ChRate(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",25,language));
    aqObject.CheckProperty(Get_OrderGrid_ChOurRole(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",26,language));
    aqObject.CheckProperty(Get_OrderGrid_ChOrderNo(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",27,language));
    aqObject.CheckProperty(Get_OrderGrid_ChNextBusinessDay(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",28,language));
    aqObject.CheckProperty(Get_OrderGrid_ChFinancialInstrument(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",29,language));
    aqObject.CheckProperty(Get_OrderGrid_ChExecutedMarket(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",30,language));
    aqObject.CheckProperty(Get_OrderGrid_ChCodedTrailer(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",31,language));    
    aqObject.CheckProperty(Get_OrderGrid_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",3,language));
    aqObject.CheckProperty(Get_OrderGrid_ChAccountName(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",4,language));
    aqObject.CheckProperty(Get_OrderGrid_ChCfoCxl(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",5,language));
    Scroll();
    aqObject.CheckProperty(Get_OrderGrid_ChType(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",6,language));
    aqObject.CheckProperty(Get_OrderGrid_ChTypeColor(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",7,language));
    aqObject.CheckProperty(Get_OrderGrid_ChQuantity(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",8,language));
    aqObject.CheckProperty(Get_OrderGrid_ChSymbol(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",9,language));
    aqObject.CheckProperty(Get_OrderGrid_ChDescription(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",10,language));
    aqObject.CheckProperty(Get_OrderGrid_ChPrice(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",11,language));
    aqObject.CheckProperty(Get_OrderGrid_ChGoodTill(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",12,language));
    aqObject.CheckProperty(Get_OrderGrid_ChExecutedQty(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",13,language));
    aqObject.CheckProperty(Get_OrderGrid_ChExecutedPrice(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",14,language));
    aqObject.CheckProperty(Get_OrderGrid_ChMarket(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",15,language));
    aqObject.CheckProperty(Get_OrderGrid_ChLastModification(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",16,language));
    aqObject.CheckProperty(Get_OrderGrid_ChExecutionDate(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",17,language));
    aqObject.CheckProperty(Get_OrderGrid_ChIACode(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",18,language));
    aqObject.CheckProperty(Get_OrderGrid_ChSupplierNo(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",19,language));
    aqObject.CheckProperty(Get_OrderGrid_ChAlternativeOrderNo(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",20,language));
    aqObject.CheckProperty(Get_OrderGrid_ChSource(), "Content", cmpEqual, GetData(filePath_Orders,"Grid_column_header",21,language));
    
    if (!Get_OrderGrid_ChSource().VisibleOnScreen)
        Scroll(); //Christophe : Stabilisation
    
    Get_OrderGrid_ChSource().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
  
}


function Scroll()
{
    //cliquer sur scrollbar pour faire l'entête de colonne visible
    var ControlWidth=Get_OrderGrid().Width;
    var ControlHeight=Get_OrderGrid().Height;
    //for (i=1; i<=28; i++) { Get_SecurityGrid().Click(ControlWidth-20, ControlHeight-5)} 
    Get_OrderGrid().Click(ControlWidth-40, ControlHeight-5);
    ReduceColumnsHeadersWidthToMaxValue();
}

function ScrollBack()
{
    //cliquer sur scrollbar pour faire l'entête de colonne visible
    var ControlWidth=Get_OrderGrid().Width;
    var ControlHeight=Get_OrderGrid().Height;
    //for (i=1; i<=28; i++) { Get_SecurityGrid().Click(ControlWidth-20, ControlHeight-5)} 
    Get_OrderGrid().Click(20,ControlHeight-5);
    ReduceColumnsHeadersWidthToMaxValue();
}


/**
    Auteur : Christophe Paring
*/
function ReduceColumnsHeadersWidthToMaxValue(maxWidth)
{
    maxWidth = (maxWidth == undefined)? 60: maxWidth;
    
    maxLoops = 3;
    for (var k = 1; k <= maxLoops; k++){
        var allDisplayedHeaders = Get_OrderGrid().FindAllChildren(["ClrClassName", "WPFControlText", "VisibleOnScreen"], ["LabelPresenter", "*", true], 10).toArray();
    
        //Reorder objects from left most to right most
        var orderedDisplayedHeaders = [];
        while (orderedDisplayedHeaders.length < allDisplayedHeaders.length){
            var leftMostIndex = null;
            for (var j = 0; j < allDisplayedHeaders.length; j++){
                if (allDisplayedHeaders[j] !== null && (leftMostIndex === null || allDisplayedHeaders[j].ScreenLeft < allDisplayedHeaders[leftMostIndex].ScreenLeft))
                    leftMostIndex = j;
            }
            orderedDisplayedHeaders.push(allDisplayedHeaders[leftMostIndex]);
            allDisplayedHeaders[leftMostIndex] = null;
        }
    
        //Modify width if necessary
        var isHeaderWidthReduced = false;
        for (var i = 0; i < (orderedDisplayedHeaders.length-1); i++){
            if (Trim(orderedDisplayedHeaders[i].WPFControlText) != "" && orderedDisplayedHeaders[i].Width > maxWidth){
                var fromX = orderedDisplayedHeaders[i].ScreenLeft + orderedDisplayedHeaders[i].Width;
                var fromY = orderedDisplayedHeaders[i].ScreenTop + orderedDisplayedHeaders[i].Height/2 - 1;
                var toX = fromX - (orderedDisplayedHeaders[i].Width - maxWidth);
                var toY = fromY;
            
                LLPlayer.MouseDown(MK_LBUTTON, fromX, fromY, 200);
                LLPlayer.MouseMove(toX, toY, 500)
                LLPlayer.MouseUp(MK_LBUTTON, toX, toY, 300);
                isHeaderWidthReduced = true;
            }
        }
        
        if (isHeaderWidthReduced)
            Sys.Refresh();
        else
            break;
    }
}
