/*
Question 1: What are the top-paying Data Analyst jobs in Singapore?
- Identify the TOP 10 highest-paying Data Analyst positions available in Singapore.
- Focus on job postings with specified salaries (exclude NULLs).
- Bonus: Include the hiring company for each position.

Reason:
- To highlight which Data Analyst roles offer the highest compensation and
    provides insight into the employers offering premium salaries 
    within Singapore's data analytics market.
*/

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

/*
Result:

Here's a breakdown of the TOP 10 highest-paying Data Analyst position in Singapore in 2023:
1. Research-focused roles offer the highest salaries.
The top three highest-paying positions are Research Scientist roles at Bosch Group, each offering an annual salary of $149,653. This suggests that roles combining data analysis with research and technical expertise receive higher compensation than standard Data Analyst positions.
2. Specialised Data Analyst roles are highly valued across industries.
The remaining top-paying jobs include roles such as Fraud Data Analyst, Carbon Data Analyst, and Market Data Specialist, with salaries ranging from $105,000 to $111,175. These opportunities are found in industries such as finance, gaming, sustainability, and technology, showing that specialised analytical skills are in demand across different sectors.
3. Most high-paying opportunities are full-time positions.
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

Table 1. Top 10 Highest-Paying Data Analyst Job Postings in Singapore (2023)
*/