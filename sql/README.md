# 📄 Relatório da Análise SQL

Resultados obtidos a partir das consultas em [`consulta_estudantes.sql`](consulta_estudantes.sql), executadas sobre o banco `dados/estudantes.db` (SQLite), tabela `estudantes` (1000 registros).

---

## Visão geral

| Indicador | Valor |
|---|---|
| Total de estudantes | 1000 |
| Estudantes por sexo | 510 mulheres / 490 homens |
| Nota final média | 83,54 |
| Nota anterior média | 69,74 |
| Nota final: mínima / máxima | 46,8 / 100,0 |

### Quantidade de alunos por conceito final

| Conceito | Qtd. estudantes |
|---|---|
| A | 284 |
| B | 354 |
| C | 261 |
| D | 89 |
| F | 12 |

**A maioria dos alunos tem notas boas ou ruins?** A maioria tem notas boas: 638 dos 1000 alunos (63,8%) têm conceito A ou B, contra apenas 101 (10,1%) com D ou F.

---

## Diferença dos indicadores entre homens e mulheres

| Sexo | Tempo de estudo (h) | Frequência (%) | Sono (h) | Nota anterior | Nota final |
|---|---|---|---|---|---|
| Feminino | 3,56 | 84,96 | 6,81 | 69,83 | 83,61 |
| Masculino | 3,58 | 85,23 | 6,79 | 69,65 | 83,48 |

Praticamente não há diferença entre os sexos em nenhum dos indicadores.

---

## Quanto maior o tempo dedicado aos estudos, maior tende a ser a nota final?

| Horas de estudo/dia | Nota média |
|---|---|
| 1h | 73,65 |
| 2h | 77,31 |
| 3h | 80,93 |
| 4h | 84,83 |
| 5h | 88,96 |
| 6h | 93,34 |
| 7h | 96,12 |
| 8h | 98,30 |

**Sim.** É o fator com a relação mais forte e direta encontrada na análise: a nota média sobe de forma quase linear conforme aumentam as horas de estudo.

Isso é confirmado pela quebra em faixas:

| Faixa de estudo | Nota média |
|---|---|
| Até 2h | 74,79 |
| 2–4h | 81,16 |
| 4–6h | 88,49 |
| Mais de 6h | 95,32 |

---

## Alunos com presença alta possuem notas maiores?

| Frequência | Nota média |
|---|---|
| Alta (≥90%) | 86,41 |
| Média (70–90%) | 82,69 |
| Baixa (<70%) | 76,91 |

**Sim.** Quanto maior a frequência, maior a nota média — diferença de quase 10 pontos entre frequência alta e baixa.

---

## A quantidade de horas dormidas melhora o desempenho das notas?

| Horas de sono | Nota média |
|---|---|
| Alto (≥7h) | 85,11 |
| Baixo (<4h) | 82,34 |
| Médio (4–7h) | 82,19 |

**Efeito positivo, porém fraco** — a diferença entre o grupo com mais sono e os demais é pequena (~3 pontos), bem menor que o efeito do tempo de estudo e da frequência.

---

## Alunos com pais mais escolarizados apresentam melhores resultados?

| Escolaridade dos pais | Nota média |
|---|---|
| PhD | 85,06 |
| Masters | 84,03 |
| (não informado) | 83,44 |
| Bachelors | 83,40 |
| High School | 83,23 |

**Não de forma relevante.** A variação entre a maior e a menor média é de menos de 2 pontos — a escolaridade dos pais não se mostra um fator determinante isolado.

---

## O acesso à internet influencia o desempenho?

| Acesso à internet | Nota média |
|---|---|
| Sim | 84,28 |
| Não | 79,26 |

**Sim.** Alunos com acesso à internet têm nota média cerca de 5 pontos maior.

---

## Participar de atividades extracurriculares melhora as notas?

| Atividades extracurriculares | Nota média |
|---|---|
| Sim | 83,74 |
| Não | 83,28 |

**Praticamente sem efeito** — diferença de menos de 0,5 ponto.

---

## Trabalhar reduz o rendimento escolar?

| Trabalho de meio período | Nota média |
|---|---|
| Não | 84,58 |
| Sim | 81,29 |

**Sim.** Alunos que trabalham têm nota média cerca de 3,3 pontos menor.

---

## Estudantes que já tinham bom desempenho tendem a manter boas notas?

A nota final acompanha, em geral, a tendência da nota anterior — quem tinha nota anterior mais alta tende a ter nota final mais alta —, mas com **bastante dispersão** entre casos individuais, não sendo uma garantia. Exemplos extremos: alunos com nota anterior 90 chegam a nota final média de 91,18, enquanto alunos com nota anterior 35 têm nota final média de apenas 53,2, mostrando que outros fatores (estudo, frequência) também pesam bastante.

---

## Perfil dos melhores alunos (conceito A)

| Horas de estudo | Frequência (%) | Horas de sono |
|---|---|---|
| 4,65 | 88,08 | 7,02 |

## Comparação entre o perfil dos melhores (A) e piores (F) alunos

| Conceito | Horas de estudo | Frequência (%) | Horas de sono |
|---|---|---|---|
| A | 4,65 | 88,08 | 7,02 |
| F | 1,97 | 77,02 | 6,46 |

Alunos com conceito A estudam mais que o dobro das horas dos alunos com conceito F, têm frequência ~11 pontos percentuais maior e dormem um pouco mais.

---

## Top 15 estudantes com maior nota final

| student_id | Sexo | Nota anterior | Nota final |
|---|---|---|---|
| 1 | Masculino | 76,9 | 100,0 |
| 2 | Feminino | 75,5 | 100,0 |
| 22 | Masculino | 83,9 | 100,0 |
| 33 | Feminino | 67,7 | 100,0 |
| 35 | Feminino | 69,7 | 100,0 |
| 43 | Feminino | 95,7 | 100,0 |
| 51 | Masculino | 66,5 | 100,0 |
| 88 | Masculino | 98,4 | 100,0 |
| 109 | Feminino | 65,2 | 100,0 |
| 131 | Feminino | 80,0 | 100,0 |
| 167 | Feminino | 82,0 | 100,0 |
| 189 | Masculino | 90,9 | 100,0 |
| 192 | Masculino | 83,0 | 100,0 |
| 207 | Feminino | 79,7 | 100,0 |
| 220 | Masculino | 67,8 | 100,0 |

---

## 🧭 Conclusão

Os fatores mais fortemente associados ao desempenho acadêmico, em ordem de impacto, são:

1. **Tempo de estudo** — o fator mais determinante, com relação praticamente linear com a nota final.
2. **Frequência às aulas** — forte associação positiva.
3. **Acesso à internet** e **ausência de trabalho de meio período** — associação moderada.
4. **Horas de sono** — efeito positivo, mas fraco.

**Gênero, escolaridade dos pais e atividades extracurriculares** não mostraram associação relevante com a nota final neste conjunto de dados.
