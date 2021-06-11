-- Aggregate table to map spells to their source books
CREATE TABLE m_spell_source_book
(
    spell_name          VARCHAR2(50 CHAR)   CONSTRAINT mssb_spell_nn NOT NULL,
    book_code           VARCHAR2(5 CHAR)    CONSTRAINT mssb_book_nn NOT NULL,
);

-- COMMENTS
COMMENT ON TABLE m_spell_source_book IS 'Maps spells to their containing source book.';
COMMENT ON COLUMN m_spell_source_book.spell_name IS 'Name of spell as it appears in source material, foreign key to s_spell.';
COMMENT ON COLUMN m_spell_source_book.book_code IS 'Source book code, foreign key to r_source_book.';

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
