/*
Question 3: What are the most in-demand skills for Data Analysts in Singapore?
- Identify the TOP 5 in-demand skills for a Data Analyst in Singapore.
- Examine all available job postings; this differs from the previous analysis,
    which focused solely on the highest-paying positions.

Reason:
- Retrieves the TOP 5 skills with the highest demand in the Singapore job market,
    providing insights into the most valuable skills for job seekers.
*/

SELECT
    skills,
    COUNT(job_post_list.job_id) AS demand_count
FROM
    job_post_list
INNER JOIN
    skills_job ON job_post_list.job_id = skills_job.job_id
INNER JOIN
    skills_list ON skills_job.skill_id = skills_list.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_country = 'Singapore'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

/*
Result:

Here's the breakdown of the most demanded skills for Data Analysts in Singapore (2023):
1. SQL and Python are the most in-demand skills
This indicates that database querying and programming are fundamental skills for Data Analyst roles in Singapore.
2. Excel, Tableau, and R remain highly valued by employers.
This shows that spreadsheet analysis, data visualisation, and statistical programming are important skills for analysing data and communicating business insights effectively.

| Rank | Skill | Job Postings |
|-----:|-------|-------------:|
| 1 | SQL | 3,665 |
| 2 | Python | 3,110 |
| 3 | Excel | 2,309 |
| 4 | Tableau | 2,216 |
| 5 | R | 1,326 |

Table 2. Top 5 Most In-Demand Skills for Data Analyst Jobs in Singapore (2023)
*/