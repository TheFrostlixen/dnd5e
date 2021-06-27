-- Aggregate table to map spells to their source books
CREATE TABLE m_spell_source_book
(
    spell_name          VARCHAR(50)   NOT NULL,
    book_code           VARCHAR(5)    NOT NULL
);

-- PRIMARY KEY
ALTER TABLE m_spell_source_book
    ADD CONSTRAINT mssb_pk PRIMARY KEY(spell_name, book_code);

-- FOREIGN KEYS
ALTER TABLE m_spell_source_book ADD 
(
    CONSTRAINT mssb_spell_fk
    FOREIGN KEY(spell_name)
    REFERENCES s_spell(spell_name),
    CONSTRAINT mssb_book_fk
    FOREIGN KEY(book_code)
    REFERENCES r_source_book(book_code)
);
