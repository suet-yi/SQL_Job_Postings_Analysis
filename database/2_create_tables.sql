-- Create company_list table with primary key
CREATE TABLE public.company_list
(
    company_id INT PRIMARY KEY,
    name TEXT,
    link TEXT,
    link_google TEXT,
    thumbnail TEXT
);

-- Create skills_list table with primary key
CREATE TABLE public.skills_list
(
    skill_id INT PRIMARY KEY,
    skills TEXT,
    type TEXT
);

-- Create job_post_list table with primary key
CREATE TABLE public.job_post_list
(
    job_id INT PRIMARY KEY,
    company_id INT,
    job_title_short VARCHAR(255),
    job_title TEXT,
    job_location TEXT,
    job_via TEXT,
    job_schedule_type TEXT,
    job_work_from_home BOOLEAN,
    search_location TEXT,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country TEXT,
    salary_rate TEXT,
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC,
    FOREIGN KEY (company_id) REFERENCES public.company_list (company_id)
);

-- Create skills_job table with a composite primary key and foreign keys
CREATE TABLE public.skills_job
(
    job_id INT,
    skill_id INT,
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES public.job_post_list (job_id),
    FOREIGN KEY (skill_id) REFERENCES public.skills_list (skill_id)
);

-- Set ownership of the tables to the postgres user
ALTER TABLE public.company_list OWNER to postgres;
ALTER TABLE public.skills_list OWNER to postgres;
ALTER TABLE public.job_post_list OWNER to postgres;
ALTER TABLE public.skills_job OWNER to postgres;

-- Create indexes on foreign key columns for better performance
CREATE INDEX idx_company_id ON public.job_post_list (company_id);
CREATE INDEX idx_skill_id ON public.skills_job (skill_id);
CREATE INDEX idx_job_id ON public.skills_job (job_id);