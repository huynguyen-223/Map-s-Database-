CREATE LOGIN sManager WITH PASSWORD = '123456'
CREATE USER sManager FOR LOGIN sManager
GRANT ALL ON DATABASE_ASS2 TO sManager