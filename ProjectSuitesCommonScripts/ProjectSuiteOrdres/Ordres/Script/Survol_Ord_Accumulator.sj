//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.  
vérifier le texte des en-têtes dans la partie "Accumulator". */

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
    ReduceColumnsHeadersWidthToMaxValue();
    
    //btn
    aqObject.CheckProperty(Get_OrderAccumulator_BtnVerify().Content, "OleValue", cmpEqual, GetData(filePath_Orders,"Accumulator",21,language));
    aqObject.CheckProperty(Get_OrderAccumulator_BtnEdit().Content, "OleValue", cmpEqual, GetData(filePath_Orders,"Accumulator",22,language));
    aqObject.CheckProperty(Get_OrderAccumulator_BtnMerge().Content, "OleValue", cmpEqual, GetData(filePath_Orders,"Accumulator",23,language));
    aqObject.CheckProperty(Get_OrderAccumulator_BtnSplit().Content, "OleValue", cmpEqual, GetData(filePath_Orders,"Accumulator",24,language));
    aqObject.CheckProperty(Get_OrderAccumulator_BtnDelete().Content, "OleValue", cmpEqual, GetData(filePath_Orders,"Accumulator",25,language));
    
    Log.Message("Bug JIRA BNC-1311");
    
    Get_OrderAccumulatorGrid_ChAccountNo().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    ReduceColumnsHeadersWidthToMaxValue();
    
    //aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChInclude(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",3,language)); //Correction d’anomalie CROES-7939
    //aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChMessage(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",4,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",5,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChAccountName(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",6,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChType(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",7,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChQuantity(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",8,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChSymbol(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",9,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChDescription(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",10,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChPrice(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",11,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChMarket(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",12,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChGoodTill(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",13,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChNextBusinessDay(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",14,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChIACode(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",15,language));
    //aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChSupplierNo(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",16,language));La colonne a été enlevée suit FBNAGILE1-1125 
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChSource(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",17,language));
       
        
    //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
    var numTry = 0;
    do { //Christophe : Stabilisation
        Delay(3000);
        Get_OrderAccumulatorGrid_ChAccountNo().ClickR();
    } while ((++numTry) <= 3 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500))
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500);

    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 5); // ca vient de  GDO-1253 la colonne "pro" vas toujours s'afficher à partir de la version 90.14 
    
    
    Get_OrderAccumulatorGrid_ChAccountNo().ClickR()
    while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
    {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_OrderAccumulatorGrid_ChAccountNo().ClickR()
    }
    ReduceColumnsHeadersWidthToMaxValue();

    //aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChInclude(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",3,language)); //Correction d’anomalie CROES-7939
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChOrderNo(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",18,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChLastModification(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",19,language));
    //aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChMessage(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",4,language)); //Correction d’anomalie CROES-7939
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",5,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChAccountName(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",6,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChType(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",7,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChQuantity(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",8,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChSymbol(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",9,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChDescription(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",10,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChPrice(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",11,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChMarket(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",12,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChGoodTill(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",13,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChNextBusinessDay(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",14,language));
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChIACode(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",15,language));
    //aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChSupplierNo(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",16,language));La colonne a été enlevée suit FBNAGILE1-1125 
    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChSource(), "Content", cmpEqual, GetData(filePath_Orders,"Accumulator",17,language));
    
    Get_OrderAccumulatorGrid_ChAccountNo().ClickR()
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
  
}


/**
    Auteur : Christophe Paring
*/
function ReduceColumnsHeadersWidthToMaxValue(maxWidth)
{
    maxWidth = (maxWidth == undefined)? 60: maxWidth;
    
    maxLoops = 3;
    for (var k = 1; k <= maxLoops; k++){
        var allDisplayedHeaders = Get_OrderAccumulatorGrid().FindAllChildren(["ClrClassName", "WPFControlText", "VisibleOnScreen"], ["LabelPresenter", "*", true], 10).toArray();
    
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
