USE cob_pac
GO
CREATE TABLE tabla_nombre ( 
 codigo int NOT NULL,
 nombre varchar(25) NOT NULL,
 CONSTRAINT codigo PRIMARY KEY NONCLUSTERED(codigo)
 )
GO