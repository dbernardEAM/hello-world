--Insertion des commande d'erreur 
INSERT INTO r5errsource (ers_source, ers_type, ers_desc, ers_number, ers_code)
VALUES ('VEINT', 'PROC', 'Modification impossible', '1', 'VEINTFX11')

--Insertion des messages
INSERT INTO R5ERRTEXTS (ERT_CODE, ERT_TEXT, ERT_LANG, ERT_TRANSLATE)
VALUES ('VEINTFX11', 'Le STATUS ne peut être ''A MODIF'' ', 'FR', '-')

--Appel dans le flex
o7err.raise_error ('VEINT', 'PROC', 1);

INSERT INTO r5errsource (ers_source, ers_type, ers_desc, ers_number, ers_code)
VALUES ('CODA_INT', 
		'TRIG', 
		NULL, 
		'9', 
		'CODA_INT_9')
GO

INSERT INTO R5ERRTEXTS (ERT_CODE, ERT_TEXT, ERT_LANG, ERT_TRANSLATE)
SELECT  'CODA_INT_9', 
		'Groupe d''articles non autorisé sur OT sur parc «Article en erreur :PARAM1».', 
		lin_code, 
		'-' 
FROM r5langinst