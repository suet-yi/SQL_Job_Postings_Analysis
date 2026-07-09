# Introduction
# Background
# Tools I used
# The Analysis

### Question 1: What are the highest-paying Data Analyst jobs in Singapore?
To identify the highest-paying Data Analyst jobs in Singapore, I filtered job postings for Data Analyst roles with specified annual salaries and excluded records with missing salary information. I then joined the company table to include employer names and ranked the results by salary in descending order to retrieve the top 10 highest-paying positions.

```sql
SELECT
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM 
    job_post_list
LEFT JOIN 
    company_list ON job_post_list.company_id = company_list.company_id
WHERE 
    job_title_short = 'Data Analyst'
    AND job_country = 'Singapore'
    AND salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC,
    job_posted_date DESC
LIMIT 10;
```

Here's a breakdown of the TOP 10 highest-paying Data Analyst position in Singapore in 2023:
1. **Research-focused roles offer the highest salaries.**

    The top three highest-paying positions are Research Scientist roles at Bosch Group, each offering an annual salary of $149,653. This suggests that roles combining data analysis with research and technical expertise receive higher compensation than standard Data Analyst positions.
2. **Specialised Data Analyst roles are highly valued across industries.**

    The remaining top-paying jobs include roles such as Fraud Data Analyst, Carbon Data Analyst, and Market Data Specialist, with salaries ranging from $105,000 to $111,175. These opportunities are found in industries such as finance, gaming, sustainability, and technology, showing that specialised analytical skills are in demand across different sectors.
3. **Most high-paying opportunities are full-time positions.**

    Nine of the top ten highest-paying jobs are full-time roles, while only one is a contract position. This indicates that employers are more likely to offer higher salaries for permanent Data Analyst positions in Singapore.

| Rank | Job Title | Company | Employment Type | Annual Salary (USD) |
|-----:|-----------|---------|-----------------|--------------------:|
| 1 | Research Scientist - Thermal Systems | Bosch Group | Full-time | 149,653 |
| 2 | Research Scientist - Instrumented Living Spaces | Bosch Group | Full-time | 149,653 |
| 3 | Research Scientist - Energy System | Bosch Group | Full-time | 149,653 |
| 4 | Data Analyst, Mobile | 2K | Full-time | 111,175 |
| 5 | Fraud Data Analyst | Adyen | Full-time | 111,175 |
| 6 | Data Analyst | ADDX | Full-time | 111,175 |
| 7 | Data Analyst, Mobile (12-month Fixed Term Contract) | 2K | Contractor | 111,175 |
| 8 | Carbon Data Analyst, FiscalNote ESG Solutions | FiscalNote | Full-time | 111,175 |
| 9 | Market Data Specialist, Feeds | Jane Street | Full-time | 109,500 |
| 10 | Data Analyst | ADDX | Full-time | 105,000 |

*Table of the Top 10 Highest-Paying Data Analyst Job Postings in Singapore (2023)*

### Question 2: What skills are required for the highest-paying Data Analyst jobs in Singapore?
To identify the skills required for the highest-paying Data Analyst jobs, I first selected the top 10 highest-paying positions from the previous analysis. I then joined the job postings with the skills tables to retrieve the technical skills associated with each role, allowing me to identify the competencies most commonly required by high-paying employers.

```sql
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
```

Here's the breakdown of the most required skills for the TOP 10 highest-paying Data Analyst position in Singapore in 2023:
1. **Python, SQL, and Spark are the most common technical skills among the highest-paying jobs.**

    Python appears in many of the top-paying roles, while SQL is required for several Data Analyst positions. Spark is also a key skill for the highest-paying Research Scientist roles at Bosch Group, showing the importance of programming and big data technologies.
2. **Business intelligence and data visualisation tools are frequently required.**

    Tools such as Tableau and Power BI appear across multiple high-paying job postings. This suggests that employers value candidates who can analyse data and present insights through dashboards and visual reports.
3. **The required skills vary depending on the industry and job specialisation.**

    Standard Data Analyst roles commonly require SQL, Python, Excel, and Power BI, while specialised roles require additional skills such as AWS, Hadoop, Linux, and Spark. This indicates that developing both core data analysis skills and industry-specific technical knowledge can improve access to higher-paying opportunities.

![Top_Paying_Skills](figures\2_top_paying_jobs_skills.png)
*Bar graph visualizing the frequency of each skill apprearing in the Top 10 highest-paying Data Analyst job postings in Singapore (2023).*

### Question 3: What are the most in-demand skills for Data Analysts in Singapore?
To identify the most in-demand skills for Data Analysts in Singapore, I joined the job postings table with the skills tables using the job ID and skill ID. I then filtered the dataset to include all Data Analyst job postings in Singapore, counted how many times each skill appeared across the postings, and ranked the skills by demand to identify the top five most requested skills.

```sql
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
```

Here's the breakdown of the most demanded skills for Data Analysts in Singapore (2023):
1. **SQL and Python are the most in-demand skills.**

    This indicates that database querying and programming are fundamental skills for Data Analyst roles in Singapore.
2. **Excel, Tableau, and R remain highly valued by employers.**

    This shows that spreadsheet analysis, data visualisation, and statistical programming are important skills for analysing data and communicating business insights effectively.

This result also supports the findings from Question 2. While Python, SQL, and Tableau are among the most common skills in the highest-paying Data Analyst jobs, they are also the most frequently requested skills across all job postings. This suggests that mastering these core technical skills can improve both employability and opportunities to qualify for higher-paying roles.

| Rank | Skill | Demand Count |
|-----:|-------|-------------:|
| 1 | SQL | 3,665 |
| 2 | Python | 3,110 |
| 3 | Excel | 2,309 |
| 4 | Tableau | 2,216 |
| 5 | R | 1,326 |

*Table 2. Top 5 Most In-Demand Skills for Data Analyst Jobs in Singapore (2023)*

# What I learned
# Conclusions
