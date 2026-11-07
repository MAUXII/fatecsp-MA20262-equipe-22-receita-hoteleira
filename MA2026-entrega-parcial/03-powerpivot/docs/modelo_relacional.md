# Modelo relacional - Rede Hoteleira

## Grão e tabelas

fReservas: uma acomodação de uma reserva, com data e hora de check-in, hotel, tipo de acomodação, diárias, diária, desconto e valores bruto/líquido. ID_Reserva é repetível: uma reserva pode conter dois quartos do mesmo tipo. Arquivo_Origem + Linha_Origem identificam a origem aceita; não formam uma dimensão de negócio.

fMetas: hotel e mês. Meta_Ocupacao é uma proporção, não uma receita; Meta_Diarias = Meta_Ocupacao × quartos × dias do mês. Não dividir receita por uma porcentagem de ocupação. Analisar metas em nível mensal ou acima.

dAcomodacao: 12 linhas, PK Cod_Acomodacao. dHotel: 4 linhas, PK Cod_Hotel. dCalendario: 365 datas contínuas de 2025, PK Data. Rejeitados: 1.593 linhas, sem relacionamento.

## Relações ativas 1:N

| Dimensão / PK | Fato / FK |
|---|---|
| dAcomodacao[Cod_Acomodacao] | fReservas[Cod_Acomodacao] |
| dHotel[Cod_Hotel] | fReservas[Cod_Hotel] |
| dCalendario[Data] | fReservas[Data_Checkin] |
| dHotel[Cod_Hotel] | fMetas[Cod_Hotel] |
| dCalendario[Data] | fMetas[Mes_Inicio] |

O filtro parte da dimensão para a fato. Nenhuma relação direta une as duas fatos. dCalendario[Data] e as duas FKs temporais usam o tipo data. Não relacionar Rejeitados à fato.

## Medidas e validações

23 medidas completas em `../dax/medidas_preliminares.dax`. Os códigos estão no formato padrão (separador vírgula); no Excel com Windows em português o separador é ponto e vírgula.

Receita de Hospedagem é líquida de desconto. ADR = receita líquida / diárias vendidas. Custo Total usa RELATED(dAcomodacao[Custo]). Taxa de Ocupação e RevPAR dividem pelo total de quartos cadastrados × dias do período. A atribuição da estadia inteira ao check-in é uma aproximação; não representa ocupação diária real. Feriado é provisório (false) e não participa das conclusões.

A aba Conferencia lê medidas por CUBEVALUE, comparando receita e contagens com a Etapa 2. PK duplicada e FKs órfãs retornam zero. A tabela dinâmica agrupa hotel e AnoMes.
