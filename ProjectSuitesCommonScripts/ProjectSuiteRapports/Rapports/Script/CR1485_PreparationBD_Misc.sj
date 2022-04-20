//USEUNIT CR1485_Common_functions
//USEUNIT CR1485_123_Common_functions



function CR1485_PreparationBD_Misc()
{
    try {
        //Le dossier C:\CroesusWeb est nécessaire pour les scripts suivants : CR1485_129, CR1485_130, CR1485_131, CR1485_132, CR1485_133, CR1485_134, CR1485_135, ...
        CopyCroesusWebFolder();
        
        //L'exécution de la fonction ActivateDelegator est nécessaire pour des rapports 123 et des rapports 001
        ActivateDelegator(vServerReportsCR1485);
    }
    catch(exception_CR1485_PreparationBD_Misc) {
        Log.Error("Exception from CR1485_PreparationBD_Misc(): " + exception_CR1485_PreparationBD_Misc.message, VarToStr(exception_CR1485_PreparationBD_Misc.stack));
        exception_CR1485_PreparationBD_Misc = null;
    }
    finally{
        //Sauvegarder le log pour Christophe
        //Log.SaveResultsAs("\\\\srvfs1\\pub\\aq\\Conseillers QA\\Christophe\\Execution\\Rapports_PreparationBD_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S") + "\\", lsXML, true, lesFull);
    }
}