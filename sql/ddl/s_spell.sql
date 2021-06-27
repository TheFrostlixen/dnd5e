-- Create spells table 
CREATE TABLE s_spell
(
    spell_name          VARCHAR(50)    		NOT NULL,
    spell_level         INT(1)              NOT NULL,
    school_code         VARCHAR(3)    		NOT NULL,
    casting_code        VARCHAR(3)   		NOT NULL,
    ritual              VARCHAR(1)    		DEFAULT 'N'
                                            NOT NULL
                                            CHECK (ritual IN ('Y','N')),
    concentration       VARCHAR(1)    		DEFAULT 'N'
                                            NOT NULL
                                            CHECK (concentration IN ('Y','N')),
    vsm_component       VARCHAR(3)    		NOT NULL,
    mat_component       VARCHAR(400)  		,
    spell_range         VARCHAR(10)   		NOT NULL,
    duration            VARCHAR(50)   		NOT NULL,
    descr               TEXT                NOT NULL,
    higher_levels       TEXT                
);

-- PRIMARY KEY
ALTER TABLE s_spell
    ADD CONSTRAINT spell_pk PRIMARY KEY(spell_name);

-- INDEX
CREATE INDEX spell_lvl_fk_idx ON s_spell(spell_level);
CREATE INDEX spell_school_fk_idx ON s_spell(school_code);
CREATE INDEX spell_cast_fk_idx ON s_spell(casting_code);

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
