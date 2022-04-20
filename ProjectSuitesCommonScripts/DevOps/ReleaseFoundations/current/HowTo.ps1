$vserverName = "devBuild05"
$reference = "ref90-04-9249--V9-CX_1-co6x"

Import-Module "$PSScriptRoot\ReleaseFoundations.psm1" -Force
#Start-VServer $vserverName

$script =       "# PopCroesus à off par défaut`n" +
                "chkconfig cfpopcroesus off`n`n" +
                "# Pour les tests automatiques`n" +
                "echo `"REPORT_SRV_DEST_DEBUG_DATASET:1`" >> /etc/finansoft/croesus.conf`n" +
                "# Fichiers des données pour le chargeur`n" +
                "cd /home/loader/data`n" +
                "wget -q -r -np -nH --cut-dirs=2 -A .xml http://devarch/archives/loaderDataFiles/`n`n" +
                "cp -f /etc/finansoft/FrameworkServer.exe.config /tmp/ && sed -e 's/ key=`"TestMode`" value=`".*`"/ key=`"TestMode`" value=`"True`" /g' /tmp/FrameworkServer.exe.config > /etc/finansoft/FrameworkServer.exe.config"



#Edit-VServer -VServerName $vserverName -Reference "ref90-04-54--V9-1_7-co6x" -Database "dev_syb78@devrefbd" -AssembleScript $script
#Edit-VServer -VServerName $vserverName -Reference $reference -AssembleScript "$script"
#Restart-VServer $vserverName
#Stop-VServer $vserverName

#Get-Reference
#Get-Database -Group "dev" -DatabaseName "dev_syb90@devrefbd"
#Get-Database -Group "dev"
Get-Master -Group "demo"
#Get-Master -Group "dev" -MasterName "devapp1"
