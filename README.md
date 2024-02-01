# Login
psql --username=freecodecamp --dbname=postgres

# Dump
pg_dump -cC --inserts -U freecodecamp salon > salon.sql

# Rebuild
psql -U postgres < salon.sql