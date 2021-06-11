-- Create source book reference table
CREATE TABLE r_source_book
(
    book_code           VARCHAR2(5 CHAR)    CONSTRAINT srcbk_code_nn NOT NULL,
    book_name           VARCHAR2(100 CHAR)  CONSTRAINT srcbk_name_nn NOT NULL
);

-- COMMENTS
COMMENT ON TABLE r_source_book IS 'Stores the names and abbreviations of source books.';
COMMENT ON COLUMN r_source_book.book_code IS 'Standard abbreviation of source book name, to map to the main spells table.';
COMMENT ON COLUMN r_source_book.book_name IS 'Source book full name.';

-- PRIMARY KEY
ALTER TABLE r_source_book
    ADD CONSTRAINT srcbk_pk PRIMARY KEY(book_code);
