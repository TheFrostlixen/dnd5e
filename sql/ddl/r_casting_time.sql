-- Create casting time reference table 
CREATE TABLE r_casting_time
(
    casting_code        VARCHAR2(3 CHAR)    CONSTRAINT cast_code_nn NOT NULL,
    casting_string      VARCHAR2(20 CHAR)   CONSTRAINT cast_str_nn NOT NULL
);

-- COMMENTS
COMMENT ON TABLE r_casting_time IS 'Stores the names of all casting times for spells.';
COMMENT ON COLUMN r_casting_time.casting_code IS 'Casting time code, to map to the spells table.';
COMMENT ON COLUMN r_casting_time.casting_string IS 'Full text of the casting time item.';

-- PRIMARY KEY
ALTER TABLE r_casting_time
    ADD CONSTRAINT cast_pk PRIMARY KEY(casting_code);
