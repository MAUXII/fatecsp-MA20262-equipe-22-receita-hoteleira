// Conf_Motivos
Table.Sort(Table.Group(Rejeitados,{"Motivo"},{{"Linhas",each Table.RowCount(_),Int64.Type}}),{{"Linhas",Order.Descending}})