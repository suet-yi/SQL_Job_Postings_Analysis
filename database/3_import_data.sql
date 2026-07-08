/* 

Import data via PostgreSQL - pgAdmin 4

Steps:
1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_project` database
3. Right-click `sql_project` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    - Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool` one by one, (with the CORRECT file path)

\copy company_list FROM '[your file path]\company_list.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_list FROM '[your file path]\skills_list.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_post_list FROM '[your file path]\job_post_list.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job FROM '[your file path]\skills_job.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/

-- Check if the data has been imported

SELECT COUNT(*) FROM company_list;
SELECT COUNT(*) FROM skills_list;
SELECT COUNT(*) FROM job_post_list;
SELECT COUNT(*) FROM skills_job;

SELECT * FROM job_post_list LIMIT 50;