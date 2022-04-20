//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      Un message d'erreur s'affiche et empêche la sauvegarde lorsque qu'on essaye de changer le code d'industrie.

    Auteur : Sana Ayaz
    Anomalie:BNC-1100
    Version de scriptage:90-04-BNC-59B-9
   
*/
  function BNC_1100_ErrorSavingAnIndustryCodeChangeOnATitle()
  {
      try {
        
        
          userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
          passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
          //Se connecter avec KEYNEJ
          Login(vServerTitre, userNameUNI00, passwordUNI00, language);
       
          var DescriptBNC_1100=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "DescriptBNC_1100", language+client);
          var TextIndusryCodeBNC_1100=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "TextIndusryCodeBNC_1100", language+client);
          
          Get_ModulesBar_BtnSecurities().Click();
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); //EM : pour supprimer tous les filtres
          Search_SecurityByDescription(DescriptBNC_1100)
          Get_SecurityGrid().Find("Value",DescriptBNC_1100,10).Click();
          
          Get_SecuritiesBar_BtnInfo().Click();
          //Modification du code d'industrie
         
          Get_WinInfoSecurity_GrpDescription_CmbIndustryCode().Keys(TextIndusryCodeBNC_1100)
          Get_WinInfoSecurity_BtnOK().Click();
         //Les points de vérification : SA:Je vais vérifier juste que le code d'industrie a été modifié parce que j'ai pas pu reproduire le message d'erreur pour pouvoir inspecter le message d'Erreur affichée
          Search_SecurityByDescription(DescriptBNC_1100)
          Get_SecurityGrid().Find("Value",DescriptBNC_1100,10).Click();
          Get_SecuritiesBar_BtnInfo().Click();
          aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbIndustryCode(), "Text", cmpEqual, TextIndusryCodeBNC_1100);
          
      }
      catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
          Terminate_CroesusProcess();
         
        
      }
  }
