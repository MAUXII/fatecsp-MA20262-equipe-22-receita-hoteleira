// Rejeitados
let
 Origem=stg_Reservas_Bruto,
 Mescla=Table.NestedJoin(Origem,{"Arquivo_Origem","Linha_Origem"},fReservas,{"Arquivo_Origem","Linha_Origem"},"Aceita",JoinKind.LeftAnti),
 SoRejeitadas=Table.RemoveColumns(Mescla,{"Aceita"}),
 Hoteis=List.Buffer(cad_DeParaChave[Chave_Hotel]), Acomodacoes=List.Buffer(cad_AcomodacaoChave[Chave_Acomodacao]),
 ENumero=(v)=>v=null or (try (Number.From(v,"pt-BR") is number) otherwise false),
 Chave=(v)=>if v=null then null else Text.Upper(fnLimparTexto(v)),
 Diagnostico=(r as record) as text => let Data=fnData(r[Data_Checkin]) in
 if List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(Record.SelectFields(r,ColunasAlvo)),{"",null})) then "Linha em branco"
 else if r[ID_Reserva]=null or Text.Trim(Text.From(r[ID_Reserva]))="" then "ID_Reserva vazio"
 else if r[Diarias]=null then "Diárias vazia" else if r[Diarias]=0 then "Diárias zero"
 else if Data=null then "Data inválida" else if Data<pDataInicio or Data>pDataFim then "Data fora do período"
 else if fnHora(r[Hora_Checkin])=null then "Hora inválida"
 else if not (ENumero(r[Diarias]) and ENumero(r[Valor_Diaria]) and ENumero(r[Desconto])) then "Valor não numérico"
 else if r[Valor_Diaria]=null or Number.From(r[Diarias],"pt-BR")<=0 then "Diárias ou valor inválido"
 else if not List.Contains(Hoteis,Chave(r[Hotel])) then "Hotel sem correspondência"
 else if not List.Contains(Acomodacoes,Chave(r[Acomodacao])) then "Acomodação não cadastrada" else "Linha duplicada",
 ComMotivo=Table.AddColumn(SoRejeitadas,"Motivo",each Diagnostico(_),type text),
 Ordenada=Table.Sort(ComMotivo,{{"Arquivo_Origem",Order.Ascending},{"Linha_Origem",Order.Ascending}})
in Ordenada