-- Create source book reference table
CREATE TABLE r_source_book
(
    book_code           VARCHAR(5)    NOT NULL,
    book_name           VARCHAR(100)  NOT NULL
);

-- PRIMARY KEY
ALTER TABLE r_source_book
    ADD CONSTRAINT srcbk_pk PRIMARY KEY(book_code);
