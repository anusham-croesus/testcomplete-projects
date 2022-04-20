update B_USER set MOTPASSE = "GZz7m3vOe"
update B_USER set RECOVERY_EMAIL_CONFIRMED = 'N'
update B_USER set RECOVERY_EMAIL = ''
update B_USER set EMAIL = ''
update B_USER set VALIDATION_CODE_COUNT = null
update B_USER set HASH = null
update B_USER set SALT = null
update B_USER set HASH_VERSION = 0
update B_USER set LAST_PSWD_CHNGE = null
update B_USER set VALIDATION_KEY = null
update B_USER set VALIDATION_CODE_EXPIRATION = null
update B_USER set PSWD_TENTATIVE_COUNT = 0
update B_USER set PSWD_REINIT = 0
update B_USER set BLOCKING_TYPE=''
update B_USER set VALIDATION_CODE=null
INSERT INTO b_licence_rights(SOFTWARE_ID,FIRM_ID,REF_ID) values (4,1,136)
INSERT INTO b_licence_rights(SOFTWARE_ID,FIRM_ID,REF_ID) values (4,1,115)
update B_USER set HASH = null, SALT = null, HASH_VERSION = 0, MOTPASSE = "GZz7m3vOe",ACTIF = "Y", PSWD_TENTATIVE_COUNT = 0, VALIDATION_CODE_COUNT = 0,EXPIRATION = null, PSWD_REINIT = 0, BLOCKING_TYPE = null, RECOVERY_EMAIL_CONFIRMED = 'Y', RECOVERY_EMAIL = 'testauto_' + rtrim(B_USER.STATION_ID) + '@auto.com', EMAIL = 'testauto_' + rtrim(B_USER.STATION_ID) + '@auto.com', VALIDATION_KEY = null, VALIDATION_CODE_EXPIRATION = null where STATION_ID = "UNI00"
update B_USER set HASH = null, SALT = null, HASH_VERSION = 0, MOTPASSE = "GZz7m3vOe",ACTIF = "Y", PSWD_TENTATIVE_COUNT = 0, VALIDATION_CODE_COUNT = 0,EXPIRATION = null, PSWD_REINIT = 0, BLOCKING_TYPE = null, RECOVERY_EMAIL_CONFIRMED = 'Y', RECOVERY_EMAIL = 'testauto_' + rtrim(B_USER.STATION_ID) + '@auto.com', EMAIL = 'testauto_' + rtrim(B_USER.STATION_ID) + '@auto.com', VALIDATION_KEY = null, VALIDATION_CODE_EXPIRATION = null where STATION_ID = "FORDGE"

go