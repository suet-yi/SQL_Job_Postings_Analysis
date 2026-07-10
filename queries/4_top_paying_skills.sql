/*
Question 4: What are the top-paying skills for Data Analysts in Singapore?
- Explores which technical skills are associated with the highest average salaries for Data Analyst roles.

Reason:
- By comparing the average salary for each skill, the analysis identifies the
    technical skills that provide the greatest earning potential.
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_yearly_salary
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
    skills
ORDER BY
    avg_yearly_salary DESC
LIMIT 10;

/*
Results:

Here's a breakdown of results for top-paying skills for Data Analysts in Singapore (2023):
1. Big data and specialised analytics tools command the highest salaries.
Spark, Looker, and Linux are associated with the highest average salaries, suggesting that employers pay a premium for advanced technical skills beyond traditional data analysis.
2. Python remains one of the most valuable core skills.
While tools such as Spark and Looker offer higher average salaries, Python ranks among the top-paying skills and also appeared as one of the most in-demand skills in the previous analyses, making it one of the strongest skills to learn for both employability and earning potential.

| Rank | Skill | Average Annual Salary ($) |
|-----:|-------|----------------------------:|
| 1 | Spark | 121,027 |
| 2 | Looker | 111,175 |
| 3 | Linux | 109,500 |
| 4 | Flow | 105,558 |
| 5 | Python | 103,713 |
| 6 | Excel | 100,569 |
| 7 | Qlik | 100,500 |
| 8 | NumPy | 100,500 |
| 9 | Pandas | 100,500 |
| 10 | SAS | 100,500 |

Table 3. Top 10 Highest-Paying Technical Skills for Data Analyst Jobs in Singapore.
General productive tools (e.g., Word, PowerPoint, Outlook, Zoom, Slack) are excluded to focus on technical skills.

*/