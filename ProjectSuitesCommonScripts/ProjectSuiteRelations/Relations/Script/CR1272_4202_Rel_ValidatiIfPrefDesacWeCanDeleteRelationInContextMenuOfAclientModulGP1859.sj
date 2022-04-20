//USEUNIT CR1272_4202_Rel_ValidatiIfPrefActivWeCanDeleteRelationInContextMenuOfAclientModulGP1859
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR1272_4199_Rel_ValidatIfPREFActivForAcessLevelAllUserWithThisAccessLevelHaveAccessToTheDeleteGP1859

/**


    Description :
                 https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4202
                            
                  1-Connect to the configurator  set PREF_ENABLE_RELATIONSHIP_DELETE=yes  for sysadmin access level
                  connect to croesus with uni00 in the clients module in the details section select a relationship and validate if we can delete a relationship with contextual menu (right-click)  
                  résultat attendu:
                  we can delete a relationship with contextual menu (right-click)  
                  
                  1-Connect to the configurator  set PREF_ENABLE_RELATIONSHIP_DELETE=no  for sysadmin access level
                  connect to croesus with uni00 in the clients module in the details section select a relationship and validate if  delete 
                  button in contextual menu (right-click) is disabled 
                  résultat attendu:
                  delete button in contextual menu (right-click) is disabled 


          Auteur : Sana Ayaz
          Version de scriptage:	ref90-08-Dy-1--V9-Be_1-co6x
         */
   
function CR1272_4202_Rel_ValidatiIfPrefActivWeCanDeleteRelationInContextMenuOfAclientModulGP1859()
{
  if (client == "CIBC"){
    var UserName=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
    var PassWord=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
    }
  else{
    var UserName=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
    var PassWord=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
  }
 var NumBerClientGP1859=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "NumBerClientGP1859", language+client);
 var defaultValueIntial=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "defaultValueIntial", language+client);
 var defaultValueChange=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "defaultValueChange", language+client);
 var RelationNameGP1859=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "RelationNameGP1859", language+client);
 var valueActivPref = "False";

 CR1272_4202_Rel_ValidatiIfPrefActivWeCanDeleteRelationInContextMenuOfAclient(UserName,PassWord,NumBerClientGP1859,defaultValueIntial,defaultValueChange,RelationNameGP1859,valueActivPref);
}