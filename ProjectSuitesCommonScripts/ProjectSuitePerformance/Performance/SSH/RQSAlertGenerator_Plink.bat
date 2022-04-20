chcp 1252 
echo y | plink -ssh root@nfrTestQA2 -pw TestsAuto2019!! -m RQSAlertGenerator.sh > RQSAlertGenerator_Output.txt