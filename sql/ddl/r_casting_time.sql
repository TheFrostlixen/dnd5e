-- Create casting time reference table 
CREATE TABLE r_casting_time
(
    casting_code        VARCHAR(3)    NOT NULL,
    casting_string      VARCHAR(20)   NOT NULL
);

-- PRIMARY KEY
ALTER TABLE r_casting_time
    ADD CONSTRAINT cast_pk PRIMARY KEY(casting_code);
