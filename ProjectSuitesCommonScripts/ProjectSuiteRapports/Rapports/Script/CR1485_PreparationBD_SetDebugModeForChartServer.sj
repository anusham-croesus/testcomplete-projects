//USEUNIT CR1485_Common_functions


/**
    Configurer le fichier etc/finansoft/ChartServer.exe.config en mode DEBUG afin de recueillir toutes les données de l'exécution
*/
function CR1485_PreparationBD_SetDebugModeForChartServer()
{
    try {
        ///Configurer le fichier etc/finansoft/ChartServer.exe.config en mode DEBUG afin de recueillir toutes les données de l'exécution
        SetDebugModeForChartServer(vServerReportsCR1485);
    }
    catch(exception_CR1485_PreparationBD_SetDebugModeForChartServer) {
        Log.Error("Exception from CR1485_PreparationBD_SetDebugModeForChartServer(): " + exception_CR1485_PreparationBD_SetDebugModeForChartServer.message, VarToStr(exception_CR1485_PreparationBD_SetDebugModeForChartServer.stack));
        exception_CR1485_PreparationBD_SetDebugModeForChartServer = null;
    }
    finally {
        //redémarrer les services
        RestartServices(vServerReportsCR1485);
    }
}