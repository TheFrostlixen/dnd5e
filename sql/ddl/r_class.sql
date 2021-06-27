-- Create class reference table 
CREATE TABLE r_class
(
    class_code          VARCHAR(3)    NOT NULL,
    class_name          VARCHAR(20)   NOT NULL
);

-- PRIMARY KEY
ALTER TABLE r_class
    ADD CONSTRAINT class_pk PRIMARY KEY(class_code);
