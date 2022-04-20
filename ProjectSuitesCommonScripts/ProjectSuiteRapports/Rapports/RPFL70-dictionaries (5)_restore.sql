-- Supprimer les entrees des dictionnaires 63, 64 et65

delete from b_dict where code_dict=63 and (indexdict>=1 and indexdict<=4)

delete from b_dict where code_dict=64 and (indexdict>=1 and indexdict<=55)

delete from b_dict where code_dict=65 and (indexdict>=2 and indexdict<=7)

go