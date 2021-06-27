-- Create spell level reference table 
CREATE TABLE r_spell_level
(
    spell_level         TINYINT(1)          NOT NULL,
    spell_level_string  VARCHAR(8)    NOT NULL
);

-- PRIMARY KEY
ALTER TABLE r_spell_level
    ADD CONSTRAINT splvl_pk PRIMARY KEY(spell_level);
