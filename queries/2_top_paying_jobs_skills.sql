/*
Question 2: What skills are required for the highest-paying Data Analyst jobs in Singapore?
- Reuse the Top 10 highest-paying Data Analyst jobs identified in Question 1.
- Joins each job posting with its associated skills

Reason:
- Understanding which skills appear most frequently among the highest_paying jobs,
  helping job seekers prioritise their learning and focus on the tools and technologies
  that can improve their career opportunities and earning potential.
*/

WITH top_paying_jobs AS (
  SELECT
      job_id,
      job_title,
      name AS company_name,
      salary_year_avg
  FROM 
      job_post_list
  LEFT JOIN 
      company_list ON job_post_list.company_id = company_list.company_id
  WHERE 
      job_title_short = 'Data Analyst'
      AND job_country = 'Singapore'
      AND salary_year_avg IS NOT NULL
  ORDER BY 
      salary_year_avg DESC
  LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN
    skills_job ON top_paying_jobs.job_id = skills_job.job_id
INNER JOIN
    skills_list ON skills_job.skill_id = skills_list.skill_id
ORDER BY
    salary_year_avg DESC

/*
Result:

Here's the breakdown of the most required skills for the TOP 10 highest-paying Data Analyst position in Singapore in 2023:
1. Python, SQL, and Spark are the most common technical skills among the highest-paying jobs.
Python appears in many of the top-paying roles, while SQL is required for several Data Analyst positions. Spark is also a key skill for the highest-paying Research Scientist roles at Bosch Group, showing the importance of programming and big data technologies.
2. Business intelligence and data visualisation tools are frequently required.
Tools such as Tableau and Power BI appear across multiple high-paying job postings. This suggests that employers value candidates who can analyse data and present insights through dashboards and visual reports.
3. The required skills vary depending on the industry and job specialisation.
Standard Data Analyst roles commonly require SQL, Python, Excel, and Power BI, while specialised roles require additional skills such as AWS, Hadoop, Linux, and Spark. This indicates that developing both core data analysis skills and industry-specific technical knowledge can improve access to higher-paying opportunities.

Bar graph visualizing the frequency of each skill apprearing in the Top 10 highest-paying Data Analyst job postings in Singapore (2023).
*/