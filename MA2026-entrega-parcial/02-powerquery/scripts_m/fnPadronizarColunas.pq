// fnPadronizarColunas
(t as table) as table => let Renomeada=Table.RenameColumns(t,DeParaColunas,MissingField.Ignore), Final=Table.SelectColumns(Renomeada,ColunasAlvo,MissingField.UseNull) in Final