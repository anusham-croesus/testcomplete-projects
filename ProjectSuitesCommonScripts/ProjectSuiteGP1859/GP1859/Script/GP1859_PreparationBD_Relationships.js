//USEUNIT GP1859_Helper
//USEUNIT CR1485_PreparationBD_Relationships_Models




/**  
    
*/
function GP1859_PreparationBD_Relationships()
{
    try {
        Log.Message("GP1859_PreparationBD_Relationships()");
        
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        //Créer les relations
        CR1485_CreateRelationships();
        
        //Fermer Croesus
        CloseCroesus();

    }
    catch(exception_GP1859_PreparationBD_Relationships){
        Log.Error("Exception : " + exception_GP1859_PreparationBD_Relationships.message, VarToStr(exception_GP1859_PreparationBD_Relationships.stack));
        exception_GP1859_PreparationBD_Relationships = null;
    }
    finally {
        Terminate_CroesusProcess();
        TerminateProcess("EXCEL");
    }
}