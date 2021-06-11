-- Aggregate table to map classes with their allowable spells
CREATE TABLE m_spell_class
(
    spell_name          VARCHAR2(50 CHAR)   CONSTRAINT msc_spell_nn NOT NULL,
    class_code          VARCHAR2(3 CHAR)    CONSTRAINT msc_class_nn NOT NULL
);

-- COMMENTS
COMMENT ON TABLE m_spell_class IS 'Maps classes to the spells available to those classes.';
COMMENT ON COLUMN m_spell_class.spell_name IS 'Name of spell as it appears in source material, foreign key to s_spell.';
COMMENT ON COLUMN m_spell_class.class_code IS 'Class code, foreign key to r_class.';

-- PRIMARY KEY
ALTER TABLE m_spell_class
    ADD CONSTRAINT msc_pk PRIMARY KEY(spell_name, class_code);

-- FOREIGN KEYS
ALTER TABLE m_spell_class ADD 
(
    CONSTRAINT msc_spell_fk
    FOREIGN KEY(spell_name)
    REFERENCES s_spell(spell_name),
    CONSTRAINT msc_class_fk
    FOREIGN KEY(class_code)
    REFERENCES r_class(class_code)
);
