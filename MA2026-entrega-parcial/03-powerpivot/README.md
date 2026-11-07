# Etapa 3 — Power Pivot e DAX

Arquivo: `RedeHoteleira_03_PowerPivot.xlsx`. Organiza as tabelas tratadas da Etapa 2 em um modelo estrela e calcula os indicadores em DAX. Nenhum dado é digitado nesta etapa: tudo vem de `RedeHoteleira_02_PowerQuery.xlsx`.

## Como abrir

Ajuste o parâmetro `pArquivoEtapa2` para o caminho de `02-powerquery/RedeHoteleira_02_PowerQuery.xlsx`. Atualize e salve a Etapa 2 antes. Depois, use Dados → Atualizar Tudo.

## Tabelas e relacionamentos

| Tabela | Papel | Linhas |
|--------|-------|-------:|
| fReservas | fato (uma acomodação de uma reserva) | 9.632 |
| fMetas | fato (hotel × mês) | 48 |
| dAcomodacao | dimensão | 12 |
| dHotel | dimensão | 4 |
| dCalendario | dimensão (01/01 a 31/12/2025) | 365 |
| Rejeitados | auditoria, sem relacionamento | 1.593 |

Cinco relações 1:N ativas, com filtro da dimensão para a fato. Detalhes em `docs/modelo_relacional.md`.

## Medidas

| Medida | Pergunta que responde |
|--------|-----------------------|
| Receita Bruta / Receita de Hospedagem | Quanto a rede faturou antes e depois dos descontos? |
| Qtd Reservas / Ticket Médio | Quantas reservas e quanto cada uma rende em média? |
| Diárias Vendidas / Diárias Disponíveis | Quanto foi vendido frente à capacidade dos hotéis? |
| Taxa de Ocupação | Que fração dos quartos foi ocupada? |
| ADR | Qual a diária média vendida? |
| RevPAR | Quanto cada quarto disponível rendeu (ocupação × preço)? |
| Custo Total / Margem Bruta % | Quanto sobra depois do custo das acomodações? |
| Meta Diárias / % Meta Diárias | O hotel atingiu a meta de ocupação do mês? |
| Cresc. MoM % | Quanto a receita variou em relação ao mês anterior? |
| Conf … | Conferências de integridade e reconciliação |

Código completo em `dax/medidas_preliminares.dax`. Código M em `scripts_m/`. Capturas em `evidencias/`.

## Conferência

- Receita de Hospedagem: **R$ 12.831.102,31**, igual à soma de `Valor_Liquido` da Etapa 2 (diferença 0).
- 9.632 linhas aceitas + 1.593 rejeitadas = 11.225 lidas.
- Nenhuma chave órfã ou duplicada.

## Pendências herdadas da Etapa 2

- Grafias de hotel e acomodações fora dos cadastros (em `Rejeitados`).
- Pagamentos e canais fora da lista oficial.
- A estadia inteira é atribuída ao mês do check-in. Ocupação e RevPAR mensais são aproximações.
