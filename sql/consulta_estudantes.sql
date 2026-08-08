
-- QUAIS FATORES ESTÃO ASSOCIADOS AO DESEMPENHO ACADÊMICO DOS ESTUDANTES?


-- Análise geral da base
SELECT *

FROM estudantes;



-- Total de alunos
SELECT 
	COUNT(student_id) AS qtd_estudantes

FROM estudantes


-- Quantos alunos existem por sexo?

SELECT 
	gender,
	COUNT(student_id) AS qtd_estudantes

FROM estudantes

GROUP BY gender;



-- Quantidade de alunos por grade de notas?
SELECT 
	final_grade,
	COUNT(student_id) AS qtd_estudantes

FROM estudantes

GROUP BY final_grade;



-- Média final das notas?
SELECT 
	ROUND(AVG(final_exam_score), 2) AS media_notas
	
FROM estudantes



-- Menor e maior nota?
SELECT 
	MIN(final_exam_score) AS menor_nota,
	MAX(final_exam_score) AS maior_nota

FROM estudantes



-- Qual foi a média da nota anterior?
SELECT 
	ROUND(AVG(previous_grade), 2) AS media_nota_anterior
	
FROM estudantes



-- A maioria dos alunos tem notas boas ou ruins?
SELECT 
	final_grade,
	COUNT(student_id)

FROM estudantes

GROUP BY final_grade



-- Diferença dos indicadores entre homens e mulheres.
SELECT 
	gender,
	ROUND(AVG(study_time_hours), 2) AS med_tempo_estudo,
	ROUND(AVG(attendance_percent), 2) AS med_frequencia,
	ROUND(AVG(sleep_hours), 2) AS med_horas_sono,
	ROUND(AVG(previous_grade), 2) AS med_nota_prevista,
	ROUND(AVG(final_exam_score), 2) AS med_nota_final
	
FROM estudantes

GROUP BY gender


-- Quanto maior o tempo dedicado aos estudos, maior tende a ser a nota final?
SELECT 
	ROUND(sleep_hours) AS qtd_horas_sono,
	ROUND(AVG(final_exam_score), 2) AS nota_media
	
FROM estudantes

GROUP BY qtd_horas_sono

ORDER BY nota_media DESC



-- Alunos com presença alta possuem notas maiores?
SELECT 
	CASE 
		WHEN attendance_percent < 70 THEN "frequencia_baixa"
		WHEN attendance_percent >= 70
		AND  attendance_percent < 90 THEN "frequencia_média"
		ELSE "frequencia_alta"
	END AS frequencia,
	ROUND(AVG(final_exam_score), 2) AS nota_media
	
FROM estudantes

GROUP BY frequencia

ORDER BY nota_media DESC



-- a quantidade de horas dormidas melhora o desempenho das notas?
SELECT

	CASE 
		WHEN sleep_hours < 4 THEN "sono_baixo"
		WHEN sleep_hours >= 4
		AND sleep_hours < 7 THEN "sono_medio"
		ELSE "sono_alto"
	END AS horas_dormida,
    ROUND(AVG(final_exam_score),2) AS notas_media
    
FROM estudantes
GROUP BY horas_dormida



-- Alunos com pais mais escolarizados apresentam melhores resultados?
SELECT 
	parental_education,
	ROUND(AVG(final_exam_score), 2) AS notas_media

FROM estudantes

GROUP BY parental_education
ORDER BY notas_media DESC



-- O acesso à internet influencia o desempenho?
SELECT
    internet_access,
    ROUND(AVG(final_exam_score),2) notas_media
    
FROM estudantes

GROUP BY internet_access;



-- participar de atividades melhora as notas?
SELECT
    extracurricular_activities,
    ROUND(AVG(final_exam_score),2) media
    
FROM estudantes

GROUP BY extracurricular_activities;



-- Trabalhar reduz o rendimento escolar?
SELECT
    part_time_job,
    ROUND(AVG(final_exam_score),2) notas_media
    
FROM estudantes

GROUP BY part_time_job;



-- Estudantes que já tinham bom desempenho tendem a manter boas notas?
SELECT
    ROUND(previous_grade) AS notas_anterior,
    ROUND(AVG(final_exam_score),2) AS notas_media
    
FROM estudantes

GROUP BY ROUND(notas_anterior)

ORDER BY ROUND(notas_anterior);

-- Rank com os top 15 estudantes com maior nota

SELECT 
	student_id,
	gender,
	previous_grade,
	final_exam_score
	
FROM estudantes

ORDER BY final_exam_score DESC

LIMIT 15;



-- Perfil dos melhores alunos.
SELECT
    ROUND(AVG(study_time_hours),2) estudo,
    ROUND(AVG(attendance_percent),2) frequencia,
    ROUND(AVG(sleep_hours),2) sono
    
FROM estudantes

WHERE final_grade = "A";



-- Comparação entre o perfil dos melhores e piores alunos.
SELECT
	final_grade,
    ROUND(AVG(study_time_hours),2) estudo,
    ROUND(AVG(attendance_percent),2) frequencia,
    ROUND(AVG(sleep_hours),2) sono
    
FROM estudantes

WHERE final_grade IN ("A", "F")

GROUP BY final_grade



-- Média de notas por horas de estudos.
SELECT
	CASE
		WHEN study_time_hours <2 THEN 'Até 2h'
		WHEN study_time_hours <4 THEN '2-4h'
		WHEN study_time_hours <6 THEN '4-6h'
		ELSE 'Mais de 6h'
	END faixa,
ROUND(AVG(final_exam_score),2) media

FROM estudantes

GROUP BY faixa

ORDER BY media;




















