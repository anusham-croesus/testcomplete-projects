//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT Creation_Test_Restriction_model
//USEUNIT Creation_TESTREEQ2_model

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function Creation_TESTREEQ_model()
{
  var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTREEQ", language+client);
  CreationTESTREEQ(modelName);
}