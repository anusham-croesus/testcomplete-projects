//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1709_3318_ValidateOrdersOnSubstitute_if_Security_hasMinimumPurchase



/**
    Description : Tester le minimum d'achat lorsque le substitut est détenu dans le portefeuille
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4102
    Analyste d'assurance qualité : Manel
    Analyste d'automatisation : Emna IHM
    Version : 90.08.Er-14
*/

function CR1709_4102_ValidateMinimumPurchaseWhenSubstitute_isNotHeld_inPortfolio()
{
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4102","Cas de test TestLink : Croes-4102")        
            
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_4102", language+client);
        var NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC100", language+client);        
        var descriptionNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionNBC100", language+client);
        
        var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client) 
        var quantity1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD_4102", language+client)            
        var VM1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD_4102", language+client)
        
        var quantityFID215=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityFID215_4102", language+client)            
        var VMFID215=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMFID215_4102", language+client)
                
        ValidateMinimumPurchase(modelName,NBC100, descriptionNBC100, position1CAD, quantity1CAD, VM1CAD, quantityFID215, VMFID215)

}
