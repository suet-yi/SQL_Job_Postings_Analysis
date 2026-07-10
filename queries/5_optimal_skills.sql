/*
Question 5: What are the most optimal skills for Data Analysts in Singapore?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles.

Reason:
- By comparing both demand and earning potential, this analysis provides strategic insights
    on which technical skills Data Analysts should prioritise to improve their employability
    and maximise their salary potential.
*/

SELECT 
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
    AND job_country = 'Singapore'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_list.skills
HAVING
    COUNT(job_post_list.job_id) >= 5
ORDER BY
    avg_yearly_salary DESC,
    demand_count DESC

/*
Results:

Here's a breakdown of the most optimal skills for Data Analysts in Singapore (2023):
- Python offers the best balance of demand and salary, appearing in 12 job postings while providing an average annual salary of $103,713. This makes it one of the most valuable skills for Data Analysts in Singapore.
- SQL is the most in-demand skill, while Spark offers the highest average salary. This suggests that mastering SQL is essential for employability, whereas learning advanced technologies such as Spark can lead to higher-paying

| Skill | Demand Count | Average Annual Salary ($) |
|-------|-------------:|----------------------------:|
| Spark | 5 | 121,027 |
| Python | 12 | 103,713 |
| Excel | 8 | 100,569 |
| R | 6 | 94,676 |
| Tableau | 9 | 92,856 |
| AWS | 5 | 92,435 |
| SQL | 16 | 86,853 |

Table 4. Most Optimal Skills for Data Analyst Jobs in Singapore.

*/