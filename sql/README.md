# 📄 Relatório da Análise SQL

Este documento descreve a revisão feita no script [`consulta_estudantes.sql`](consulta_estudantes.sql), os problemas encontrados, as correções aplicadas e os principais resultados obtidos após a correção.

Banco utilizado: `dados/estudantes.db` (SQLite), tabela `estudantes` (1000 registros).

---

## 🔍 Revisão do código

O script foi executado integralmente contra o banco (`sqlite3 dados/estudantes.db < sql/consulta_estudantes.sql`) para validar sintaxe e resultados. Foram encontrados 3 problemas, todos corrigidos:

### 1. `;` faltando entre consultas (bug crítico)

Onze das vinte e uma consultas não terminavam com `;`. Como consequência, ao rodar o arquivo inteiro como script, o interpretador SQL não conseguia identificar onde uma consulta terminava e a próxima começava — trechos de instruções distintas eram concatenados em uma única instrução inválida.

Na prática, isso quebrava **3 blocos de execução**, fazendo com que **14 das 21 consultas do arquivo nunca produzissem resultado** (erro de sintaxe silencioso quando executado como script completo):

- `Total de alunos` + `Quantos alunos existem por sexo?`
- `Média final das notas?` até `O acesso à internet influencia o desempenho?` (10 consultas)
- `Comparação entre o perfil dos melhores e piores alunos.` + `Média de notas por horas de estudos.`

**Correção:** adicionado `;` ao final de todas as instruções.

### 2. Aspas duplas em literais de texto

Trechos como `WHEN attendance_percent < 70 THEN "frequencia_baixa"` e `WHERE final_grade = "A"` usavam aspas duplas para strings. Em SQL padrão (e na maioria dos SGBDs, como MySQL/PostgreSQL em modo estrito) aspas duplas identificam **colunas/identificadores**, não strings — isso geraria erro em outros bancos. Funcionava no SQLite apenas por uma regra de compatibilidade (fallback quando o identificador não existe).

**Correção:** todas as strings passaram a usar aspas simples (`'A'`, `'frequencia_baixa'` etc.), tornando o script portável.

### 3. Consulta com coluna trocada (bug de lógica)

A consulta comentada como *"Quanto maior o tempo dedicado aos estudos, maior tende a ser a nota final?"* agrupava por `sleep_hours` (horas de sono) em vez de `study_time_hours` (horas de estudo) — um erro de copy/paste que duplicava a análise de sono feita mais adiante e nunca respondia à pergunta sobre tempo de estudo.

**Correção:** a consulta passou a agrupar por `study_time_hours`.

---

## ✅ Resultados (após correção)

### Visão geral

| Indicador | Valor |
|---|---|
| Total de estudantes | 1000 |
| Sexo | 510 mulheres / 490 homens |
| Nota final média | 83,54 |
| Nota anterior média | 69,74 |
| Nota final: mínima / máxima | 46,8 / 100,0 |

### Distribuição por conceito final

| Conceito | Qtd. estudantes |
|---|---|
| A | 284 |
| B | 354 |
| C | 261 |
| D | 89 |
| F | 12 |

A maioria dos alunos (638 de 1000) tem conceito A ou B — desempenho predominantemente bom.

### Fatores associados ao desempenho

| Fator | Resultado |
|---|---|
| **Tempo de estudo** | Relação forte e direta: nota média sobe de **73,65** (1h/dia) para **98,3** (8h/dia). Fator mais determinante identificado. |
| **Frequência às aulas** | Frequência alta → nota média 86,41; média → 82,69; baixa → 76,91. |
| **Horas de sono** | Sono alto → 85,11; baixo → 82,34; médio → 82,19. Efeito existe, mas bem mais fraco que estudo/frequência. |
| **Acesso à internet** | Com acesso → 84,28; sem acesso → 79,26. Diferença relevante (~5 pontos). |
| **Trabalho de meio período** | Sem trabalho → 84,58; com trabalho → 81,29. Trabalhar reduz o desempenho médio. |
| **Atividades extracurriculares** | Praticamente sem efeito (83,74 vs 83,28). |
| **Escolaridade dos pais** | Pouca variação (83,2 a 85,1) — não é um fator determinante isolado. |
| **Gênero** | Sem diferença relevante entre homens (83,48) e mulheres (83,61) em nenhum indicador. |
| **Nota anterior** | Correlação positiva geral com a nota final, mas com bastante dispersão — não é garantia de repetição do desempenho. |

### Perfil dos melhores (A) vs. piores (F) alunos

| Conceito | Horas de estudo | Frequência (%) | Horas de sono |
|---|---|---|---|
| A | 4,65 | 88,08 | 7,02 |
| F | 1,97 | 77,02 | 6,46 |

Alunos com conceito A estudam mais que o dobro das horas, têm frequência ~11 p.p. maior e dormem um pouco mais que os alunos com conceito F.

### Nota média por faixa de horas de estudo

| Faixa | Nota média |
|---|---|
| Até 2h | 74,79 |
| 2–4h | 81,16 |
| 4–6h | 88,49 |
| Mais de 6h | 95,32 |

---

## 🧭 Conclusão

- O script SQL, após as correções, executa integralmente sem erros e todas as 21 consultas retornam resultados coerentes.
- **Tempo de estudo e frequência às aulas** são os fatores mais fortemente associados ao desempenho acadêmico.
- **Acesso à internet** e **ausência de trabalho de meio período** também favorecem notas mais altas.
- **Sono** tem efeito positivo, porém moderado.
- **Gênero, escolaridade dos pais e atividades extracurriculares** não mostraram associação relevante com a nota final neste conjunto de dados.
