# Etapa 2 — Power Query

Arquivo: `RedeHoteleira_02_PowerQuery.xlsx`. Lê a pasta com as planilhas brutas dos quatro hotéis, aplica as regras de limpeza e entrega uma única tabela tratada (`fReservas`), com todo descarte registrado em `Rejeitados`.

## Parâmetros

| Parâmetro | Valor |
|-----------|-------|
| `pPastaReservas` | pasta `01-excel/dados_brutos/reservas` |
| `pArquivoExcel` | `01-excel/RedeHoteleira_01_Excel.xlsx` (cadastros da Etapa 1) |
| `pArquivoMetas` | `01-excel/dados_brutos/metas_mensais.xlsx` |
| `pDataInicio` / `pDataFim` | 01/01/2025 / 31/12/2025 |

## Consultas

| Consulta | Função |
|----------|--------|
| `Excel_Origem`, `cad_Acomodacao`, `cad_Hotel`, `cad_DeParaHotel`, `cad_DeParaChave`, `cad_AcomodacaoChave`, `lst_Pagamento`, `lst_Canal` | Leitura dos cadastros e listas oficiais da Etapa 1 |
| `ColunasAlvo`, `DeParaColunas`, `fnPadronizarColunas`, `fnLerReservas` | Padronização dos cabeçalhos diferentes entre hotéis (D10) |
| `fnData`, `fnHora`, `fnLimparTexto`, `fnValorOficial` | Datas e horas em formatos variados, limpeza de espaços e grafia oficial |
| `stg_Reservas_Bruto` | Anexação dos quatro arquivos, com `Arquivo_Origem` e `Linha_Origem` |
| `fReservas` | Tabela tratada: nulos, duplicidades, tipos pt-BR, textos, mesclagem com hotel e acomodação, `Valor_Bruto` e `Valor_Liquido` |
| `Rejeitados` | Linhas descartadas (anti-junção) com o motivo |
| `dAcomodacao`, `dHotel` | Dimensões |
| `fMetas` | Metas mensais despivotadas (12 colunas → 48 linhas) |
| `Conf_Reconciliacao`, `Conf_Motivos`, `Conf_Colunas` | Conferências |

Código de cada consulta em `scripts_m/`. Dados tratados em `dados_limpos/fReservas.csv`. Capturas em `evidencias/`.

## Regras de rejeição e resultado

**11.225 lidas = 9.632 aceitas + 1.593 rejeitadas; diferença 0.** `Conf_Colunas` vazia.

| Motivo | Linhas |
|--------|-------:|
| Hotel sem correspondência | 1.451 |
| Linha duplicada | 44 |
| Acomodação não cadastrada | 36 |
| Diárias vazia | 16 |
| Data fora do período | 14 |
| Data inválida | 12 |
| Diárias zero | 12 |
| Hora inválida | 8 |

Diferença em relação ao guia: uma reserva pode ter dois quartos do mesmo tipo, então a duplicidade compara o registro completo da acomodação (não só reserva + item + hora). Assim, linhas legítimas não são descartadas.

## Decisões pendentes

- **Grafias de hotel fora do de-para da Etapa 1:** a maior parte dos rejeitados. Elas só entram após confirmação, acrescentadas na `Tab_DePara_Hotel`.
- **Acomodações fora do cadastro:** `Suite Master`, `Standart Casal`, `Suíte Luxo` e `Superior Vista Mar`.
- **Pagamentos e canais fora da lista:** `Debito`, `Boleto`, `Airbnb` e `Telefone`. Ficam mantidos em `fReservas` e pendentes na auditoria da Etapa 1.
