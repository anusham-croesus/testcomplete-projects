--CR1483_0210_Tit_EnvironmentPreparation_Step2

update b_config set note='2010.01.25' where cle like '%FD_LAST%'
update b_config set note='2010.01.26' where cle='FD_NEXT_PROCESS_DATE'
update b_config set note='ACTIONS=3 4 3
RANK=27
DATE=2010.01.25
AVG_TIME=5990
NO_SAMPLES=20
STATUS=2
TIME=4' where cle='FD_STATUS_F_REC'
