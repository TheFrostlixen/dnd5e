-- Create class reference table 
CREATE TABLE r_class
(
    class_code          VARCHAR2(3 CHAR)    CONSTRAINT class_code_nn NOT NULL,
    class_name          VARCHAR2(20 CHAR)   CONSTRAINT class_name_nn NOT NULL
);

-- COMMENTS
COMMENT ON TABLE r_class IS 'Stores the names of all spellcasting classes.';
COMMENT ON COLUMN r_class.class_code IS 'Class code, to map to the spells table.';
COMMENT ON COLUMN r_class.class_name IS 'Full class name.';

-- PRIMARY KEY
ALTER TABLE r_class
    ADD CONSTRAINT class_pk PRIMARY KEY(class_code);
