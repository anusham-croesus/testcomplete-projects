---Modifications au dictionnaire de restrictions pour changer les descriptions "secteur d'activit?s"
update b_dict set desc_l1 = "Pourcentage du secteur", desc_l2 = "Sector Percentage" where code_dict = 12 and indexdict = 4
go

--- TT54653
update b_dict set desc_l1 = "Secteur", desc_l2 = "Sector" where code_dict = 14 and indexdict = 2200
go

--Nouveau dictionnaires pour RPFL

---insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (63, 1, 0, "N/D", "N/A", "0", "0", "P", 1)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (63, 1, 0, "Pionnier", "Pioneer", "C", "C", "P", 1)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (63, 2, 0, "Russell", "Russel", "D", "D", "P", 2)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (63, 3, 0, "Gestion de placement professionnelle", "Professional Investment Management", "J", "J", "P", 3)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (63, 4, 0, "Radius", "Radius", "F", "F", "P", 4)
go

insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 1, 0,  "Laketon titres ? revenu fixe"                    ,       "Laketon Investment Management Fixed Income"        ,"C300", "C300", "P", 1) 
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 2, 0,  "Seamark �quilibr� - imposable"                     ,     "Seamark Asset Management Balanced - Taxable"   ,    "C302", "C302", "P", 2) 
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 3, 0,  "Foyston, Gordon & Payne Can. �q. - imposable"      ,     "Foyston Gordon & Payne Cdn Balanced - Taxable" ,    "C303", "C303", "P", 3) 
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 4, 0,  "KBSH �quilibr� - imposable"                            , "KBSH Capital Management Balanced - Taxable"        ,"C304", "C304", "P", 4) 
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 5, 0,  "Seamark �quilibr� - non-imposable"                     , "Seamark Balanced - Non-Taxable"                    ,"C305", "C305", "P", 5) 
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 6, 0,  "KBSH �quilibr� - non imposable"                        , "KBSH Balanced - Non-Taxable"                       ,"C306", "C306", "P", 6) 
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 7, 0,  "Mawer actions canadiennes"                             , "Mawer Investment Management Canadian Equity"       ,"C307", "C307", "P", 7) 
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 8, 0,  "Highstreet actions canadiennes"                        , "Highstreet Asset Management Canadian Equity"       ,"C308", "C308", "P", 8) 
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 9, 0,  "Bissett Fonds de revenu de dividendes"             ,     "Bissett Investment Management Dividend Income" ,    "C309", "C309", "P", 9) 
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 10, 0, "KBSH canadiennes �quilibr�"                        ,     "KBSH Capital Management Canadian Balanced"     ,    "C311", "C311", "P", 10)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 11, 0, "Bissett canadiennes"                               ,     "Bissett Investment Management Canadian Equity" ,    "C312", "C312", "P", 11)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 12, 0, "Sceptre canadiennes � petite capitalisation"       ,     "Sceptre Investment Counsel Canadian Small Cap" ,    "C314", "C314", "P", 12)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 13, 0, "Mawer canadiennes � petite capitalisation"         ,     "Mawer Canadian Small Cap"                      ,    "C315", "C315", "P", 13)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 14, 0, "Jarislowsky Fraser �quilibr� - imposable"              , "Jarislowsky Fraser Ltd. Balanced - Taxable"        ,"C316", "C316", "P", 14)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 15, 0, "Jarislowsky Fraser �quilibr� - non imposable"      ,     "Jarislowsky Fraser Balanced - Non-Taxable"     ,    "C317", "C317", "P", 15)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 16, 0, "Seamark seulement - imposable"                         , "Seamark Total Equity - Taxable"                    ,"C318", "C318", "P", 16)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 17, 0, "KBSH actions canadiennes"                              , "KBSH Capital Management Canadian Equity"           ,"C319", "C319", "P", 17)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 18, 0, "Seamark seulement - non imposable"                     , "Seamark Total Equity - Non-Taxable"                ,"C320", "C320", "P", 18)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 19, 0, "KBSH titres � revenu diversifi�"                        , "KBSH Capital Management Diversified Income"        ,"C321", "C321", "P", 19)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 20, 0, "Dreman actions am�ricaines"                        ,     "Dreman Value Management US Equity"             ,    "C322", "C322", "P", 20)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 21, 0, "Brandes actions am�ricaines"                           , "Brandes Investment Partners US Equity*"            ,"C324", "C324", "P", 21)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 22, 0, "Camlin  Mandat de redressement"                        , "Camlin Asset Management Ltd. Turnaround"           ,"C325", "C325", "P", 22)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 23, 0, "KBSH seulement - imposable"                            , "KBSH Total Equity - Taxable"                       ,"C326", "C326", "P", 23)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 24, 0, "Pitcairn am?ricaines � petite capitalisation"      ,     "Pitcairn Financial Group US Small Cap"         ,    "C327", "C327", "P", 24)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 25, 0, "Pitcairn toute capitalisation"                     ,     "Pitcairn Financial Group All Cap"              ,    "C329", "C329", "P", 25)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 26, 0, "UBS actions internationales"                       ,     "UBS International Equity"                      ,    "C330", "C330", "P", 26)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 27, 0, "Northroad actions internationales"                     , "Northroad International Equity"                    ,"C331", "C331", "P", 27)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 28, 0, "Brandes actions internationales"                   ,     "Brandes International Equity*"                 ,    "C332", "C332", "P", 28)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 29, 0, "Transamerica actions am�ricaines"                  ,     "Transamerica Capital Group US Equity"          ,    "C335", "C335", "P", 29)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 30, 0, "McLean Budden Fonds �quilibr� - imposable"         ,     "McLean Budden Balanced - Taxable"              ,    "C337", "C337", "P", 30)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 31, 0, "McLean Budden Fonds �quilibr� - non imposable"     ,     "McLean Budden Balanced - Non Taxable"          ,    "C338", "C338", "P", 31)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 32, 0, "Foyston, Gordon & Payne Can. �quil.- non imp."     ,     "Foyston, Gordon & Payne Cdn Bal.-Non-Taxable"  ,    "C339", "C339", "P", 32)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 33, 0, "Foyston, Gordon & Payne actions canadiennes"       ,     "Foyston, Gordon & Payne Inc. Canadian Equity"  ,    "C340", "C340", "P", 33)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 34, 0, "McLean Budden Fonds d'actions canadiennes"         ,     "McLean Budden Canadian Equity"                 ,    "C341", "C341", "P", 34)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 35, 0, "Foyston, Gordon & Payne seulement - imposable"       ,   "Foyston, Gordon & Payne Tot. Equity - Taxable" ,    "C342", "C342", "P", 35)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 36, 0, "McLean Budden seulement - imposable"               ,     "McLean Budden Total Equity - Taxable"          ,    "C343", "C343", "P", 36)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 37, 0, "Brandes actions globales"                              , "Brandes Investment Partners Global Equity*"        ,"C345", "C345", "P", 37)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 38, 0, "Foyston, Gordon & Payne Actions - non impos."      ,     "Foyston, Gordon & Payne Tot. Eq.-Non-Taxable"  ,    "C346", "C346", "P", 38)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 39, 0, "McLean Budden seulement -non imposable"            ,     "McLean Budden Total Equity - Non Taxable"      ,    "C347", "C347", "P", 39)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 40, 0, "Jarislowsky Fraser Lt?e.actions canadiennes"           , "Jarislowsky Fraser Ltd. Canadian Equity"           ,"C348", "C348", "P", 40)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 41, 0, "Jarislowsky Fraser Nord-Am�r. - imposable"             , "Jarislowsky Fraser North American - Taxable"       ,"C349", "C349", "P", 41)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 42, 0, "Jarislowsky Fraser. Nord-am�r.- non imposable"     ,     "Jarislowsky Fraser N.-American - Non-Taxable"  ,    "C350", "C350", "P", 42)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 43, 0, "KBSH seulement - non imposable"                        , "KBSH Total Equity - Non Taxable"                   ,"C351", "C351", "P", 43)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 44, 0, "KBSH actions am?ricaines"                          ,     "KBSH Capital Management US Equity"             ,    "C352", "C352", "P", 44)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 45, 0, "Mawer Fonds � traitement fiscal avantageux"        ,     "Mawer Investment Management Tax Efficient"     ,    "C353", "C353", "P", 45)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 46, 0, "McLean Budden Fonds d'actions am�ricaines"         ,     "McLean Budden US Equity"                       ,    "C354", "C354", "P", 46)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 47, 0, "Northroad actions globales"                            , "Northroad Capital Management Global Equity"        ,"C355", "C355", "P", 47)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 48, 0, "Fairlane titres � revenu fixe"                         , "Fairlane Asset Management Fixed Income"            ,"C356", "C356", "P", 48)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 49, 0, "Sionna canadiennes toutes capitalisations"             , "Sionna Investment Managers Canadian All Cap"       ,"C357", "C357", "P", 49)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 50, 0, "Brandywine actions internationales"                    , "Brandywine International Equity"                   ,"C358", "C358", "P", 50)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 51, 0, "Lazard Fonds d'actions mondiales"                  ,     "Lazard Global Equity"                          ,    "C360", "C360", "P", 51)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 52, 0, "Lazard Fonds d'actions internationales"            ,     "Lazard International Equity"                   ,    "C361", "C361", "P", 52)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 53, 0, "Sionna canadiennes �quilibr�"                      ,     "Sionna Investment Managers Canadian Balanced"  ,    "C362", "C362", "P", 53)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 54, 0, "Sionna actions canadiennes"                            , "Sionna Investment Managers Canadian Equity"        ,"C363", "C363", "P", 54)
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (64, 55, 0, "Camlin Conversion de fonds"                                  ,   "Camlin Asset Management Ltd.  Conversion"          ,"C366", "C366", "P", 55)                    
go 


--- Creation des entrees du dictionnaire 65 pour RPFL.
--insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (65, 1, 0, "RCL # 1" , "RCL # 1","1", "1", "P", 1)                    
--go
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (65, 2, 0, "RCL #2" , "RCL #2","2", "2", "P", 2)                    
go
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (65, 3, 0, "Kensington #1" , "Kensington #1","3", "3", "P", 3)                    
go
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (65, 4, 0, "Kensington #2" , "Kensington #2","4", "4", "P", 4)                    
go
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (65, 5, 0, "Kensington #3" , "Kensington #3","5", "5", "P", 5)                    
go
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (65, 6, 0, "Royal Bank" , "Royal Bank","6", "6", "P", 6)                    
go
insert into b_dict (code_dict,  indexdict, user_num, desc_l1, desc_l2, mnemonic_l1, mnemonic_l2, opts, ordre_Affi) values (65, 7, 0, "CIBC" , "CIBC","7", "7", "P", 7)                    
go

