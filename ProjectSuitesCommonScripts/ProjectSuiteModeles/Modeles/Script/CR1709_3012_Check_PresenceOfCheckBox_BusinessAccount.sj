//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_2975_CheckCreatorOfTheOrder_inAccumulator
//USEUNIT CR1709_2976_CheckCreator_WhenMergingOrders

/* Description :Rapport des taux négociés cas 2
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3012

Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x
*/ 
 
function CR1709_3012_Check_PresenceOfCheckBox_BusinessAccount()
{
    try{
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");                         
        var Account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client);
        var CheckBoxBusinessAccount=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CheckBoxBusinessAccount", language+client);
            
        Login(vServerModeles, user, psw, language);            
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(Account800049NA);  
        Get_RelationshipsClientsAccountsGrid().Find("Value",Account800049NA,10).DblClick();
        
        aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_ChkBusinessAccount(), "Exists", cmpEqual,true); 
        aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_ChkBusinessAccount(), "VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_ChkBusinessAccount(), "Content", cmpEqual,CheckBoxBusinessAccount);
        
        //Position de la case 
        var topClient=Get_WinAccountInfo_GrpAccount_LblClientNo().Top // Adaptation pour AT. Avant Get_WinAccountInfo_GrpAccount_TxtClientNo()
        var topBusinessAccount=Get_WinAccountInfo_GrpAccount_ChkBusinessAccount().Top 
        Log.Message(topBusinessAccount)
        aqObject.CompareProperty(topClient,cmpEqual,aqConvert.VarToInt(topBusinessAccount)+19,true,lmError);
        
        var leftClient=Get_WinAccountInfo_GrpAccount_LblClientNo().Left // Adaptation pour AT. Avant Get_WinAccountInfo_GrpAccount_TxtClientNo()
        var leftBusinessAccount=Get_WinAccountInfo_GrpAccount_ChkBusinessAccount().Left 
        Log.Message(leftBusinessAccount)
        aqObject.CompareProperty(leftBusinessAccount,cmpEqual,aqConvert.VarToInt(leftClient)+1,true,lmError);
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Runner.Stop(true); 
    }
}