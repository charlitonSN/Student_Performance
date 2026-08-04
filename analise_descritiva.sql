/*==============================================================
PROJETO: Student Performance Analysis
AUTOR: Kaike
OBJETIVO:
Análise Exploratória dos Dados (EDA) utilizando SQL.

Base:
Student Performance and Study Habits Dataset
==============================================================*/


/*==============================================================
1. VISÃO GERAL DA BASE
==============================================================*/


-- Total de alunos

SELECT
    COUNT(*) AS total_alunos
FROM estudantes;


---------------------------------------------------------------

-- Quantidade de alunos por gênero

SELECT
    gender,
    COUNT(*) AS quantidade
FROM estudantes
GROUP BY gender;


---------------------------------------------------------------

-- Quantidade de alunos por escolaridade dos pais

SELECT
    parental_education,
    COUNT(*) AS quantidade
FROM estudantes
GROUP BY parental_education
ORDER BY quantidade DESC;


---------------------------------------------------------------

-- Quantidade de alunos com acesso à internet

SELECT
    internet_access,
    COUNT(*) quantidade
FROM estudantes
GROUP BY internet_access;


---------------------------------------------------------------

-- Quantidade de alunos que trabalham

SELECT
    part_time_job,
    COUNT(*) quantidade
FROM estudantes
GROUP BY part_time_job;


---------------------------------------------------------------

-- Quantidade de alunos que fazem atividades extracurriculares

SELECT
    extracurricular_activities,
    COUNT(*) quantidade
FROM estudantes
GROUP BY extracurricular_activities;



/*==============================================================
2. ESTATÍSTICAS GERAIS
==============================================================*/


-- Médias gerais

SELECT

    ROUND(AVG(study_time_hours),2) media_estudo,

    ROUND(AVG(attendance_percent),2) media_frequencia,

    ROUND(AVG(sleep_hours),2) media_sono,

    ROUND(AVG(previous_grade),2) media_nota_anterior,

    ROUND(AVG(final_exam_score),2) media_nota_final

FROM estudantes;


---------------------------------------------------------------

-- Valores mínimos e máximos

SELECT

    MIN(study_time_hours) menor_estudo,
    MAX(study_time_hours) maior_estudo,

    MIN(attendance_percent) menor_frequencia,
    MAX(attendance_percent) maior_frequencia,

    MIN(sleep_hours) menor_sono,
    MAX(sleep_hours) maior_sono,

    MIN(final_exam_score) menor_nota,
    MAX(final_exam_score) maior_nota

FROM estudantes;


/*==============================================================
3. ANÁLISE DAS NOTAS
==============================================================*/


---------------------------------------------------------------
-- Distribuição dos conceitos
---------------------------------------------------------------

SELECT
    final_grade,
    COUNT(*) AS quantidade,
    ROUND(COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM estudantes),2) percentual
FROM estudantes
GROUP BY final_grade
ORDER BY quantidade DESC;



---------------------------------------------------------------
-- Faixa de notas por conceito
---------------------------------------------------------------

SELECT

    final_grade,

    MIN(final_exam_score) menor_nota,

    MAX(final_exam_score) maior_nota

FROM estudantes

GROUP BY final_grade

ORDER BY menor_nota DESC;



---------------------------------------------------------------
-- Melhor nota
---------------------------------------------------------------

SELECT
    MAX(final_exam_score) melhor_nota
FROM estudantes;



---------------------------------------------------------------
-- Pior nota
---------------------------------------------------------------

SELECT
    MIN(final_exam_score) pior_nota
FROM estudantes;



---------------------------------------------------------------
-- Perfil do aluno com a maior nota
---------------------------------------------------------------

SELECT *

FROM estudantes

WHERE final_exam_score = (

SELECT MAX(final_exam_score)

FROM estudantes

);



---------------------------------------------------------------
-- Perfil do aluno com a menor nota
---------------------------------------------------------------

SELECT *

FROM estudantes

WHERE final_exam_score = (

SELECT MIN(final_exam_score)

FROM estudantes

);



---------------------------------------------------------------
-- Top 10 melhores estudantes
---------------------------------------------------------------

SELECT *

FROM estudantes

ORDER BY final_exam_score DESC

LIMIT 10;



---------------------------------------------------------------
-- Top 10 menores notas
---------------------------------------------------------------

SELECT *

FROM estudantes

ORDER BY final_exam_score

LIMIT 10;



---------------------------------------------------------------
-- Nota média por gênero
---------------------------------------------------------------

SELECT

    gender,

    ROUND(AVG(final_exam_score),2) media

FROM estudantes

GROUP BY gender;



---------------------------------------------------------------
-- Nota média por escolaridade dos pais
---------------------------------------------------------------

SELECT

    parental_education,

    ROUND(AVG(final_exam_score),2) media

FROM estudantes

GROUP BY parental_education

ORDER BY media DESC;



---------------------------------------------------------------
-- Nota média por acesso à internet
---------------------------------------------------------------

SELECT

    internet_access,

    ROUND(AVG(final_exam_score),2) media

FROM estudantes

GROUP BY internet_access;



---------------------------------------------------------------
-- Nota média por trabalho
---------------------------------------------------------------

SELECT

    part_time_job,

    ROUND(AVG(final_exam_score),2) media

FROM estudantes

GROUP BY part_time_job;



---------------------------------------------------------------
-- Nota média por atividades extracurriculares
---------------------------------------------------------------

SELECT

    extracurricular_activities,

    ROUND(AVG(final_exam_score),2) media

FROM estudantes

GROUP BY extracurricular_activities;



---------------------------------------------------------------
-- Nota média por conceito
---------------------------------------------------------------

SELECT

    final_grade,

    ROUND(AVG(final_exam_score),2) media

FROM estudantes

GROUP BY final_grade

ORDER BY media DESC;



---------------------------------------------------------------
-- Taxa de aprovação
---------------------------------------------------------------

SELECT

ROUND(

100.0 *

SUM(

CASE

WHEN final_grade <> 'F'

THEN 1

ELSE 0

END

)/COUNT(*)

,2)

AS taxa_aprovacao

FROM estudantes;



---------------------------------------------------------------
-- Taxa de reprovação
---------------------------------------------------------------

SELECT

ROUND(

100.0 *

SUM(

CASE

WHEN final_grade='F'

THEN 1

ELSE 0

END

)/COUNT(*)

,2)

AS taxa_reprovacao

FROM estudantes;



---------------------------------------------------------------
-- Quantidade de aprovados e reprovados
---------------------------------------------------------------

SELECT

CASE

WHEN final_grade='F'

THEN 'Reprovado'

ELSE 'Aprovado'

END situacao,

COUNT(*) quantidade

FROM estudantes

GROUP BY situacao;



---------------------------------------------------------------
-- Perfil médio dos aprovados e reprovados
---------------------------------------------------------------

SELECT

CASE

WHEN final_grade='F'

THEN 'Reprovado'

ELSE 'Aprovado'

END situacao,

ROUND(AVG(study_time_hours),2) estudo,

ROUND(AVG(attendance_percent),2) frequencia,

ROUND(AVG(sleep_hours),2) sono,

ROUND(AVG(final_exam_score),2) nota

FROM estudantes

GROUP BY situacao;



---------------------------------------------------------------
-- Perfil dos alunos conceito A
---------------------------------------------------------------

SELECT

ROUND(AVG(study_time_hours),2) estudo,

ROUND(AVG(attendance_percent),2) frequencia,

ROUND(AVG(sleep_hours),2) sono,

ROUND(AVG(previous_grade),2) nota_anterior,

ROUND(AVG(final_exam_score),2) nota_final

FROM estudantes

WHERE final_grade='A';



---------------------------------------------------------------
-- Perfil dos alunos conceito F
---------------------------------------------------------------

SELECT

ROUND(AVG(study_time_hours),2) estudo,

ROUND(AVG(attendance_percent),2) frequencia,

ROUND(AVG(sleep_hours),2) sono,

ROUND(AVG(previous_grade),2) nota_anterior,

ROUND(AVG(final_exam_score),2) nota_final

FROM estudantes

WHERE final_grade='F';



---------------------------------------------------------------
-- Ranking da nota média por categoria
---------------------------------------------------------------

SELECT

parental_education,

ROUND(AVG(final_exam_score),2) media

FROM estudantes

GROUP BY parental_education

ORDER BY media DESC;


/*==============================================================
4. HÁBITOS DE ESTUDO E FATORES ASSOCIADOS AO DESEMPENHO
==============================================================*/


---------------------------------------------------------------
-- Qual o mínimo e o máximo de horas de estudo?
---------------------------------------------------------------

SELECT

    MIN(study_time_hours) AS minimo_estudo,
    MAX(study_time_hours) AS maximo_estudo

FROM estudantes;



---------------------------------------------------------------
-- Qual o mínimo e o máximo de horas de sono?
---------------------------------------------------------------

SELECT

    MIN(sleep_hours) AS minimo_sono,
    MAX(sleep_hours) AS maximo_sono

FROM estudantes;



---------------------------------------------------------------
-- Média da nota por hora de estudo
---------------------------------------------------------------

SELECT

    ROUND(study_time_hours) AS horas_estudo,

    COUNT(*) AS alunos,

    ROUND(AVG(final_exam_score),2) AS media_nota

FROM estudantes

GROUP BY ROUND(study_time_hours)

ORDER BY horas_estudo;



---------------------------------------------------------------
-- Média da nota por faixa de estudo
---------------------------------------------------------------

SELECT

CASE

WHEN study_time_hours <2 THEN 'Até 2 horas'

WHEN study_time_hours <4 THEN '2 a 4 horas'

WHEN study_time_hours <6 THEN '4 a 6 horas'

ELSE 'Mais de 6 horas'

END faixa,

COUNT(*) alunos,

ROUND(AVG(final_exam_score),2) media_nota

FROM estudantes

GROUP BY faixa

ORDER BY media_nota DESC;



---------------------------------------------------------------
-- Alunos acima e abaixo da média de frequência
---------------------------------------------------------------

WITH media AS(

SELECT

AVG(attendance_percent) media

FROM estudantes

)

SELECT

CASE

WHEN attendance_percent >=

(SELECT media FROM media)

THEN 'Acima da média'

ELSE 'Abaixo da média'

END grupo,

COUNT(*) alunos,

ROUND(AVG(final_exam_score),2) media_nota

FROM estudantes

GROUP BY grupo;



---------------------------------------------------------------
-- Faixas de frequência
---------------------------------------------------------------

SELECT

CASE

WHEN attendance_percent <70 THEN 'Baixa'

WHEN attendance_percent <85 THEN 'Média'

ELSE 'Alta'

END frequencia,

COUNT(*) alunos,

ROUND(AVG(final_exam_score),2) media_nota

FROM estudantes

GROUP BY frequencia;



---------------------------------------------------------------
-- Frequência média por conceito
---------------------------------------------------------------

SELECT

final_grade,

ROUND(AVG(attendance_percent),2) media

FROM estudantes

GROUP BY final_grade

ORDER BY media DESC;



---------------------------------------------------------------
-- Sono influencia a nota?
---------------------------------------------------------------

SELECT

CASE

WHEN sleep_hours <6 THEN 'Menos de 6h'

WHEN sleep_hours <8 THEN '6 a 8h'

ELSE 'Mais de 8h'

END faixa_sono,

COUNT(*) alunos,

ROUND(AVG(final_exam_score),2) media_nota

FROM estudantes

GROUP BY faixa_sono;



---------------------------------------------------------------
-- Média de sono por conceito
---------------------------------------------------------------

SELECT

final_grade,

ROUND(AVG(sleep_hours),2) media

FROM estudantes

GROUP BY final_grade

ORDER BY media DESC;



---------------------------------------------------------------
-- Acesso à internet influencia o desempenho?
---------------------------------------------------------------

SELECT

internet_access,

COUNT(*) alunos,

ROUND(AVG(study_time_hours),2) media_estudo,

ROUND(AVG(attendance_percent),2) media_frequencia,

ROUND(AVG(final_exam_score),2) media_nota

FROM estudantes

GROUP BY internet_access;



---------------------------------------------------------------
-- Taxa de reprovação por acesso à internet
---------------------------------------------------------------

SELECT

internet_access,

ROUND(

100*

SUM(

CASE

WHEN final_grade='F'

THEN 1

ELSE 0

END

)/COUNT(*)

,2)

taxa_reprovacao

FROM estudantes

GROUP BY internet_access;



---------------------------------------------------------------
-- Atividades extracurriculares melhoram a nota?
---------------------------------------------------------------

SELECT

extracurricular_activities,

COUNT(*) alunos,

ROUND(AVG(final_exam_score),2) media

FROM estudantes

GROUP BY extracurricular_activities;



---------------------------------------------------------------
-- Atividades diminuem o tempo de estudo?
---------------------------------------------------------------

SELECT

extracurricular_activities,

ROUND(AVG(study_time_hours),2) media_estudo,

ROUND(AVG(attendance_percent),2) media_frequencia,

ROUND(AVG(final_exam_score),2) media_nota

FROM estudantes

GROUP BY extracurricular_activities;



---------------------------------------------------------------
-- Trabalhar influencia o desempenho?
---------------------------------------------------------------

SELECT

part_time_job,

COUNT(*) alunos,

ROUND(AVG(study_time_hours),2) media_estudo,

ROUND(AVG(attendance_percent),2) media_frequencia,

ROUND(AVG(sleep_hours),2) media_sono,

ROUND(AVG(final_exam_score),2) media_nota

FROM estudantes

GROUP BY part_time_job;



---------------------------------------------------------------
-- Taxa de reprovação por trabalho
---------------------------------------------------------------

SELECT

part_time_job,

COUNT(*) total_alunos,

SUM(

CASE

WHEN final_grade='F'

THEN 1

ELSE 0

END

) reprovados,

ROUND(

100*

SUM(

CASE

WHEN final_grade='F'

THEN 1

ELSE 0

END

)/COUNT(*)

,2)

taxa_reprovacao

FROM estudantes

GROUP BY part_time_job;



---------------------------------------------------------------
-- Escolaridade dos pais influencia?
---------------------------------------------------------------

SELECT

parental_education,

COUNT(*) alunos,

ROUND(AVG(final_exam_score),2) media_nota,

ROUND(AVG(previous_grade),2) media_nota_anterior

FROM estudantes

GROUP BY parental_education

ORDER BY media_nota DESC;



---------------------------------------------------------------
-- Nota anterior influencia a nota final?
---------------------------------------------------------------

SELECT

ROUND(previous_grade) nota_anterior,

COUNT(*) alunos,

ROUND(AVG(final_exam_score),2) media_final

FROM estudantes

GROUP BY ROUND(previous_grade)

ORDER BY nota_anterior;



---------------------------------------------------------------
-- Perfil dos alunos excelentes
---------------------------------------------------------------

SELECT

ROUND(AVG(study_time_hours),2) estudo,

ROUND(AVG(attendance_percent),2) frequencia,

ROUND(AVG(sleep_hours),2) sono,

ROUND(AVG(previous_grade),2) nota_anterior,

ROUND(AVG(final_exam_score),2) nota

FROM estudantes

WHERE final_grade='A';



---------------------------------------------------------------
-- Perfil dos alunos reprovados
---------------------------------------------------------------

SELECT

ROUND(AVG(study_time_hours),2) estudo,

ROUND(AVG(attendance_percent),2) frequencia,

ROUND(AVG(sleep_hours),2) sono,

ROUND(AVG(previous_grade),2) nota_anterior,

ROUND(AVG(final_exam_score),2) nota

FROM estudantes

WHERE final_grade='F';