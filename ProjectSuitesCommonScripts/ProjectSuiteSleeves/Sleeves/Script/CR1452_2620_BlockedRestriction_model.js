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


function CR1452_2620_BlockedRestriction_model()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800236NA", language+client);
        var modelCR1075_MOD1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_MOD1", language+client);        
        var cmbSeverityHard = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CmbSeverityHard", language+client);
        var severityHard = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SeverityHard", language+client);
        var cmbSeveritySoft = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CmbSeveritySoft", language+client);
        var severitySoft = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "severitySoft", language+client);
        var restriction = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Restriction_CR1452_2611", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var winTitle=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "winTitle_CR1452_2620", language+client);
        var message= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "message_CR1425_2620", language+client); 
        
        Login(vServerSleeves, user, psw, language);      
        Get_ModulesBar_BtnModels().Click();
           
        // mettre une restriction bloquante
        SearchModelByName(modelCR1075_MOD1); 
        Get_ModelsBar_BtnRestrictions().Click();    
        EditRestriction(restriction,cmbSeverityHard,severityHard);

         //cliquer sur 'Rééquilibrer'
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_DlgError().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        aqObject.CheckProperty(Get_DlgError(), "Title", cmpEqual, winTitle);
        aqObject.CheckProperty(Get_DlgError(), "CommentTag", cmpEqual, message);
        var width = Get_DlgError().Get_Width();
        Get_DlgError().Click((width*(1/3)),73);
             
        //Remettre les données        
        Get_ModulesBar_BtnModels().Click();       
        SearchModelByName(modelCR1075_MOD1); 
        Get_ModelsBar_BtnRestrictions().Click();    
        EditRestriction(restriction,cmbSeveritySoft,severitySoft) 
                    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        //Remettre les données              
        Get_ModulesBar_BtnModels().Click();       
        SearchModelByName(modelCR1075_MOD1); 
        Get_ModelsBar_BtnRestrictions().Click();    
        EditRestriction(restriction,cmbSeveritySoft,severitySoft) 

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}