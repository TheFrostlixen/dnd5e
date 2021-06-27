-- Create school reference table 
CREATE TABLE r_school
(
    school_code         VARCHAR(3)    NOT NULL,
    school_name         VARCHAR(20)   NOT NULL
);

-- PRIMARY KEY
ALTER TABLE r_school
    ADD CONSTRAINT school_pk PRIMARY KEY(school_code);
