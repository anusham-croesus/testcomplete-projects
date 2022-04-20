function RemoveReadOnlyProtection()
{
  Log.Message(aqFileSystem.ChangeAttributes(ProjectSuite.Path + "Log\\"+FileFinder(), 128,0))
}


function FileFinder()
{
  var logFile
  var foundFiles, aFile;
  foundFiles = aqFileSystem.FindFiles(ProjectSuite.Path + "Log\\", "*.pjs.tcLogs");
  if (foundFiles != null)
    while (foundFiles.HasNext())
    {
      aFile = foundFiles.Next();
      Log.Message(aFile.Name);
      return logFile=aFile.Name;
    }
  else
    Log.Message("No files were found.");
}