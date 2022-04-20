//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_271_Rebalance_Account_WithInactiveModel
//USEUNIT CR1452_264_BlockedRestriction
//USEUNIT CR1452_2611_BlockedRestriction_Model
//USEUNIT DBA

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_2621_NonBlockedRestriction_model()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800236NA", language+client);
        var modelCR1075_MOD1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_MOD1", language+client);        
        var restriction = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Restriction_CR1452_2611", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var winTitle=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "winTitle_CR1452_2621", language+client);
        var winTitleRebalance =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "winRebalanceTitle_CR1452_2621", language+client);
        var message= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "message_CR1425_2621", language+client); 
        
        Login(vServerSleeves, user, psw, language);      
        Get_ModulesBar_BtnModels().Click();
           
        SearchModelByName(modelCR1075_MOD1); 

         //cliquer sur 'Rééquilibrer'
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_DlgConfirmation().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        aqObject.CheckProperty( Get_DlgConfirmation(), "Title", cmpEqual, winTitle);
        if(language=="french"){
          aqObject.CheckProperty( Get_DlgConfirmation(), "CommentTag", cmpEqual, message);
        } 
        else{
          //aqObject.CheckProperty( Get_DlgConfirmation(), "CommentTag", cmpContains, "The model you've selected has triggered restrictions.\rDo you want"); //Do you want to continue ?
        } 
        
        var width =  Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/4)),73);
        
        //un message non-bloquant s'affiche mais il permet de continuer
        aqObject.CheckProperty(Get_WinRebalance(), "Title", cmpEqual, winTitleRebalance);
        Get_WinRebalance_BtnClose().Click();
                    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}