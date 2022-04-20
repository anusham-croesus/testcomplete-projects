--step 1_4

update b_config set note='INCLUDE_USERS= INCLUDE_USERS a UNI00,COPERN, BELLAL, DARWIC
EXCLUDE_CATEGO=650,470'where cle = "FD_COMPLIANCE_TEST_OSSP"

--step 1_5

update b_config set NOTE="40000000" where CLE="FD_COMPLIANCE_SECURITY_ALERT_MV"

--step 1_6

update b_asset set default_rate = 1 where catego =60