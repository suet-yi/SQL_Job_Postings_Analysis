/*
Question: What are the most optimal skills to learn (aka it's in high demand and a high paying skills)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis
*/

WITH top_demanded_skills AS (
    SELECT
        skills_list.skill_id,
        skills_list.skills,
        COUNT(job_post_list.job_id) AS demand_count
    FROM
        job_post_list
    INNER JOIN
        skills_job ON job_post_list.job_id = skills_job.job_id
    INNER JOIN
        skills_list ON skills_job.skill_id = skills_list.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_list.skill_id
), top_paying_skills AS (
    SELECT
        skills_list.skill_id,
        skills_list.skills,
        ROUND(AVG(salary_year_avg),0) AS avg_yearly_salary
    FROM
        job_post_list
    INNER JOIN
        skills_job ON job_post_list.job_id = skills_job.job_id
    INNER JOIN
        skills_list ON skills_job.skill_id = skills_list.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_list.skill_id
)

SELECT 
    top_demanded_skills.skill_id,
    top_demanded_skills.skills,
    demand_count,
    avg_yearly_salary
FROM
    top_demanded_skills
INNER JOIN top_paying_skills
    ON top_demanded_skills.skill_id = top_paying_skills.skill_id
WHERE
    demand_count > 50
ORDER BY
    avg_yearly_salary DESC,
    demand_count DESC

-- rewriting this same query more concisely
SELECT 
    skills_list.skill_id,
    skills_list.skills,
    COUNT(job_post_list.job_id) AS demand_count,
    ROUND(AVG(job_post_list.salary_year_avg),0) AS avg_yearly_salary
FROM
    job_post_list
INNER JOIN
    skills_job ON job_post_list.job_id = skills_job.job_id
INNER JOIN
    skills_list ON skills_job.skill_id = skills_list.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_list.skill_id
HAVING
    COUNT(job_post_list.job_id) > 50
ORDER BY
    avg_yearly_salary DESC,
    demand_count DESC