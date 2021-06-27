-- Aggregate table to map classes with their allowable spells
CREATE TABLE m_spell_class
(
    spell_name          VARCHAR(50)   NOT NULL,
    class_code          VARCHAR(3)    NOT NULL
);

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
