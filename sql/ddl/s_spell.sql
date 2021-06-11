-- Create spells table 
CREATE TABLE s_spell
(
    spell_name          VARCHAR2(50 CHAR)   CONSTRAINT spell_name_nn NOT NULL,
    spell_level         NUMBER(1)           CONSTRAINT spell_lvl_nn NOT NULL,
    school_code         VARCHAR2(3 CHAR)    CONSTRAINT spell_school_nn NOT NULL,
    casting_code        VARCHAR2(3 CHAR)    CONSTRAINT spell_cast_nn NOT NULL,
    ritual              VARCHAR2(1 CHAR)    DEFAULT ON NULL 'N'
                                            CONSTRAINT spell_ritual_nn NOT NULL
                                            CONSTRAINT spell_ritual_ck CHECK (ritual IN ('Y','N')),
    concentration       VARCHAR2(1 CHAR)    DEFAULT ON NULL 'N'
                                            CONSTRAINT spell_conc_nn NOT NULL
                                            CONSTRAINT spell_conc_ck CHECK (concentration IN ('Y','N')),
    vsm_component       VARCHAR2(3 CHAR)    CONSTRAINT spell_vsm_nn NOT NULL,
    mat_component       VARCHAR2(400 CHAR)  ,
    spell_range         VARCHAR2(10 CHAR)   CONSTRAINT spell_range_nn NOT NULL,
    duration            VARCHAR2(50 CHAR)   CONSTRAINT spell_duration_nn NOT NULL,
    descr               TEXT                CONSTRAINT spell_descr_nn NOT NULL,
    higher_levels       TEXT                
);

-- COMMENTS
COMMENT ON TABLE s_spell IS 'Stores the information for all spells.';
COMMENT ON COLUMN s_spell.spell_name IS 'Name of spell as it appears in source material.';
COMMENT ON COLUMN s_spell.spell_level IS 'Spell level code (0-9), foreign key to r_spell_level.';
COMMENT ON COLUMN s_spell.school_code IS 'School code, foreign key to r_school.';
COMMENT ON COLUMN s_spell.casting_code IS 'Casting time code, foreign key to r_casting_time.';
COMMENT ON COLUMN s_spell.ritual IS 'Whether spell can be cast as a ritual, Y/N.';
COMMENT ON COLUMN s_spell.concentration IS 'Whether spell requires concentration, Y/N.';
COMMENT ON COLUMN s_spell.vsm_component IS 'Components required by the spell.';
COMMENT ON COLUMN s_spell.mat_component IS 'Material components, if any, required by the spell.';
COMMENT ON COLUMN s_spell.spell_range IS 'Max range of the spell.';
COMMENT ON COLUMN s_spell.duration IS 'Duration of how long the spell lasts (for concentration).';
COMMENT ON COLUMN s_spell.descr IS 'Full description of the spell, in HTML format.';
COMMENT ON COLUMN s_spell.higher_levels IS 'Full descripton of the spell at higher levels, in HTML format.';

-- PRIMARY KEY
ALTER TABLE s_spell
    ADD CONSTRAINT spell_pk PRIMARY KEY(spell_name)
    USING INDEX TABLESPACE atlas_index;

-- INDEX
CREATE INDEX spell_lvl_fk_idx ON s_spell(spell_level)
    TABLESPACE ATLAS_INDEX;
CREATE INDEX spell_school_fk_idx ON s_spell(school_code)
    TABLESPACE ATLAS_INDEX;
CREATE INDEX spell_cast_fk_idx ON s_spell(casting_code)
    TABLESPACE ATLAS_INDEX;

-- FOREIGN KEYS
ALTER TABLE s_spell ADD 
(
    CONSTRAINT spell_lvl_fk
    FOREIGN KEY(spell_level)
    REFERENCES r_spell_level(spell_level),
    CONSTRAINT spell_school_fk
    FOREIGN KEY(school_code)
    REFERENCES r_school(school_code),
    CONSTRAINT spell_cast_fk
    FOREIGN KEY(casting_code)
    REFERENCES r_casting_time(casting_code)
);
