var arrayOfTestsToBeRun = new Array();
var arrayOfNotSpecifiedTests = new Array();



function GetListOfTestsToBeRun()
{   
    var i, TestItems, Count;
    // Obtains the collection of project test items
    TestItems = Project.TestItems;
    // Defines the total number of test items in the project
    Count = TestItems.ItemCount;
    // Iterates through the project’s test items
    for (var i = 0; i < Count; i++)
        ProcessTestItem(TestItems.TestItem(i));
    
    Log.Message("Tests to be run", arrayOfTestsToBeRun);
    Log.Message("Not specified Tests", arrayOfNotSpecifiedTests);
    
    NetworkSuite.Variables.testsToBeRun = arrayOfTestsToBeRun;
    NetworkSuite.Variables.notSpecifiedTests = arrayOfNotSpecifiedTests;
    
    var slaveProjectFolderName = aqFileSystem.GetFileNameWithoutExtension(Project.FileName);
    NetworkSuite.Variables.projectFolderName = slaveProjectFolderName;
}



function ProcessTestItem(ATestItem)
{
    if (ATestItem.Enabled){
        if (ATestItem.ElementToBeRun !== null)
            arrayOfTestsToBeRun.push(ATestItem.ElementToBeRun.Caption);
        else
            arrayOfNotSpecifiedTests.push(ATestItem.Name);
        
        // If the test item contains child items, iterates through them
        for (var j = 0; j < ATestItem.ItemCount; j++){
            if (ATestItem.TestItem(j).Enabled)
                ProcessTestItem(ATestItem.TestItem(j));
        }
    }
}