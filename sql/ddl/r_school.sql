-- Create school reference table 
CREATE TABLE r_school
(
    school_code         VARCHAR2(3 CHAR)    CONSTRAINT school_code_nn NOT NULL,
    school_name         VARCHAR2(20 CHAR)   CONSTRAINT school_name_nn NOT NULL
);

-- COMMENTS
COMMENT ON TABLE r_school IS 'Stores the names of all spellcasting schools.';
COMMENT ON COLUMN r_school.school_code IS 'School code, maps to s_spell.';
COMMENT ON COLUMN r_school.school_name IS 'Full name of spellcasting school.';

-- PRIMARY KEY
ALTER TABLE r_school
    ADD CONSTRAINT school_pk PRIMARY KEY(school_code);
