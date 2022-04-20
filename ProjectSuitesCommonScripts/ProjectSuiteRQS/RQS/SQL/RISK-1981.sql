-- Mise à jour du dictionnaire 146 : RiskRatingLabels
-- Valeur par défaut (EN) : 'Risk & Compliance Manager'
-- Valeur par défaut (FR) : 'Gestionnaire du risque et de la conformité'
--
-- Valeur par CIBC (EN) : 'Risk Query System (RQS)'
-- Valeur par CIBC (FR) : 'Système d'évaluation de risque (RQS)'
------------------------------------------------------------------------

DECLARE @CodeDict SMALLINT
DECLARE @DescL1 char(45)
DECLARE @DescL2 char(45)

SELECT @CodeDict = 146
SELECT @DescL1 = "Système d'évaluation de risque (RQS)"
SELECT @DescL2 = "Risk Query System (RQS)"

IF NOT EXISTS (SELECT 1 FROM B_DICT WHERE CODE_DICT = @CodeDict AND INDEXDICT = 1)
  BEGIN
    INSERT INTO B_DICT(CODE_DICT, INDEXDICT, USER_NUM, DESC_L1, DESC_L2, MNEMONIC_L1, MNEMONIC_L2, OPTS, FIRM_ID)
    VALUES (@CodeDict, 1, 0, @DescL1, @DescL2, "1", "1", 'P', 0)
  END
ELSE
  BEGIN
    UPDATE B_DICT SET
      DESC_L1=@DescL1,
      DESC_L2=@DescL2
    WHERE CODE_DICT = @CodeDict AND INDEXDICT = 1 AND USER_NUM = 0 AND FIRM_ID = 0
  END

IF NOT EXISTS (SELECT 1 FROM B_DICT WHERE CODE_DICT = @CodeDict AND INDEXDICT = 2)
  BEGIN
    INSERT INTO B_DICT(CODE_DICT, INDEXDICT, USER_NUM, DESC_L1, DESC_L2, MNEMONIC_L1, MNEMONIC_L2, OPTS, FIRM_ID)
    VALUES (@CodeDict, 2, 0, @DescL1, @DescL2, "2", "2", 'P', 0)
  END
ELSE
  BEGIN
    UPDATE B_DICT SET
      DESC_L1=@DescL1,
      DESC_L2=@DescL2
    WHERE CODE_DICT = @CodeDict AND INDEXDICT = 2 AND USER_NUM = 0 AND FIRM_ID = 0
  END  
GO