#!/bin/bash

configFilePath='/etc/finansoft/reportgenerator.conf'
delegatorEnginesOriginal='ReportGeneratorEngines=com.croesus.reportGenerator.crystalclear.CrystalClearTemplate,10,10;'
delegatorEnginesAppend='com.croesus.reportGenerator.delegator.DelegatorTemplate,0,1;'
delegatorHost='vmqawin'
delegatorPort='6556'

echo
echo "https://confluence.croesus.com/pages/viewpage.action?pageId=10584857"
echo "Update config file '${configFilePath}' for External documents reports..."
#sed -i "s#${delegatorEnginesOriginal}#${delegatorEnginesOriginal}${delegatorEnginesAppend}#" ${configFilePath}
#sed -i "s#${delegatorEnginesOriginal}${delegatorEnginesAppend}${delegatorEnginesAppend}#${delegatorEnginesOriginal}${delegatorEnginesAppend}#" ${configFilePath}
sed -i "/ReportGeneratorEngines=com.croesus.reportGenerator.crystalclear.CrystalClearTemplate/c ${delegatorEnginesOriginal}${delegatorEnginesAppend}" ${configFilePath}
sed -i "/DelegateToReportGeneratorName=/c DelegateToReportGeneratorName=${delegatorHost}" ${configFilePath}
sed -i "/DelegateToReportGeneratorPort=/c DelegateToReportGeneratorPort=${delegatorPort}" ${configFilePath}
sed -i "s#\#DelegateOfTemplateType#DelegateOfTemplateType#" ${configFilePath}
sed -i "s#\# \+DelegateOfTemplateType#DelegateOfTemplateType#" ${configFilePath}
echo "Done."
echo
echo "Restarting VServer services..."
sudo service cfadm restart
echo "Sleeping 15 seconds..."
sleep 15
echo "Done."
