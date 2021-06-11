-- Create spell level reference table 
CREATE TABLE r_spell_level
(
    spell_level         NUMBER(1)           CONSTRAINT splvl_lvl_nn NOT NULL,
    spell_level_string  VARCHAR2(8 CHAR)    CONSTRAINT splvl_str_nn NOT NULL
);

-- COMMENTS
COMMENT ON TABLE r_spell_level IS 'Stores the spell levels.';
COMMENT ON COLUMN r_spell_level.spell_level IS 'Numerical spell level, to map to the spells table.';
COMMENT ON COLUMN r_spell_level.spell_level_string IS 'Full string of the spell level name.';

-- PRIMARY KEY
ALTER TABLE r_spell_level
    ADD CONSTRAINT splvl_pk PRIMARY KEY(spell_level);
