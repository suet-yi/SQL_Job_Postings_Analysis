# Introduction
The demand for Data Analysts continues to grow, but understanding which skills and opportunities offer the greatest career value can be challenging for job seekers. This project analyses Data Analyst job postings in Singapore to identify the highest-paying jobs, the most in-demand skills, and the skills that provide the best balance between market demand and salary, helping aspiring Data Analysts make informed career decisions.

🔍 SQL queries? Check them out here: [sql_queries_folder](/queries/)

# Dataset
This project uses a job postings dataset featured in [Luke Barousse's SQL Course](https://www.lukebarousse.com/sql) on YouTube. The dataset contains job postings from 2023, including information such as job titles, companies, salaries, locations, and required skills. It provides a realistic dataset for exploring the data analyst job market using SQL.

# Tools Used
To conduct an in-depth analysis of the job market for Data Analyst roles, I used the following key tools:
1. **SQL** – Used to query, filter, aggregate, and analyse job posting data.
2. **PostgreSQL** – Served as the relational database for storing and managing the dataset.
3. **Visual Studio Code** – Used to write, organise, and execute SQL queries efficiently.
4. **Git & GitHub** – Used for version control and to publish the project as a portfolio that showcases SQL skills.

# Business Questions
The following business questions guide the analysis of the Singapore Data Analyst job market. Each question focuses on a different aspect of career opportunities, from salary trends to skill demand, providing practical insights for aspiring Data Analysts.
1. What are the highest-paying Data Analyst jobs in Singapore?
2. What skills are required for the highest-paying Data Analyst jobs in Singapore?
3. What are the most in-demand skills for Data Analysts in Singapore?
4. What are the top-paying skills for Data Analysts in Singapore?
5. What are the most optimal skills for Data Analysts in Singapore?

# The Analysis
The analysis was performed using SQL to explore salary trends, employer requirements, and skill demand within the Singapore Data Analyst job market. Each business question is supported by SQL queries, data visualisations, and key insights.

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

| Rank | Job Title | Company | Employment Type | Annual Salary ($) |
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

*Table showing the Top 10 highest-paying Data Analyst job postings in Singapore (2023).*

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

*Table showing the Top 5 most in-demand skills for Data Analyst jobs in Singapore (2023).*

### Question 4: What are the top-paying skills for Data Analysts in Singapore?
To identify the highest-paying skills for Data Analysts in Singapore, I joined the job postings table with the skills tables using the job ID and skill ID. I then filtered the dataset to include only Data Analyst jobs in Singapore with specified annual salaries. Next, I calculated the average salary for each skill, grouped the results by skill, and ranked them in descending order to identify the top 10 highest-paying skills.

```SQL
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
```

Here's a breakdown of results for top-paying skills for Data Analysts in Singapore (2023):
1. **Big data and specialised analytics tools command the highest salaries.**

    Spark, Looker, and Linux are associated with the highest average salaries, suggesting that employers pay a premium for advanced technical skills beyond traditional data analysis.
2. **Python remains one of the most valuable core skills.**

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

*Table showing the Top 10 highest-paying technical skills for Data Analyst jobs in Singapore (2023). General productive tools (e.g., Word, PowerPoint) are excluded to focus on technical skills.*

### Question 5: What are the most optimal skills for Data Analysts in Singapore?
To identify the most optimal skills for Data Analysts in Singapore, I joined the job postings table with the skills tables and filtered for Data Analyst positions located in Singapore with specified annual salaries. I then counted how often each skill appeared in job postings and calculated its average annual salary. Finally, I ranked the skills based on demand while also considering their average salary to identify skills that offer both strong job opportunities and high earning potential.

```sql
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
```

Here's a breakdown of the most optimal skills for Data Analysts in Singapore (2023):
- **Python offers the best balance of demand and salary**, appearing in 12 job postings while providing an average annual salary of $103,713. This makes it one of the most valuable skills for Data Analysts in Singapore.
- **SQL is the most in-demand skill**, while Spark offers the highest average salary. This suggests that mastering SQL is essential for employability, whereas learning advanced technologies such as Spark can lead to higher-paying

| Skill | Demand Count | Average Annual Salary ($) |
|-------|-------------:|----------------------------:|
| Spark | 5 | 121,027 |
| Python | 12 | 103,713 |
| Excel | 8 | 100,569 |
| R | 6 | 94,676 |
| Tableau | 9 | 92,856 |
| AWS | 5 | 92,435 |
| SQL | 16 | 86,853 |

*Table showing the most optimal skills for Data Analyst jobs in Singapore (2023).*

# What I learned
Throughout this project, I expanded my SQL toolkit by applying a variety of techniques to answer real-world business questions, including:
- Improved my ability to write complex SQL queries using joins, aggregations, and Common Table Expressions (CTEs).
- Learned how to transform raw data into meaningful business insights by answering practical analytical questions.
- Gained experience analysing the relationship between salary, skill demand, and career opportunities.
- Strengthened my understanding of data storytelling by presenting findings through tables, charts, and concise insights.
- Developed a complete SQL portfolio project that demonstrates both technical querying skills and analytical thinking.

# Conclusions
### Key Insights
The analysis shows that while SQL and Python are the most in-demand skills for Data Analysts in Singapore, specialised technologies such as Spark are associated with the highest salaries. Skills such as Python, Tableau, and Excel provide a strong balance between market demand and earning potential, making them valuable areas for aspiring Data Analysts to focus on.

### Closing Thoughts
This project demonstrates how SQL can be used to extract meaningful insights from real-world job market data. By combining data querying, analysis, and visualisation, the project provides practical recommendations for skill development while showcasing the SQL techniques and analytical skills required in a Data Analyst role.