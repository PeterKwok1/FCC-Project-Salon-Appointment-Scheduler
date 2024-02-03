# Shortcuts
sudo service postgresql restart
psql --username=freecodecamp --dbname=salon

# Dump
pg_dump -cC --inserts -U freecodecamp salon > salon.sql

# Rebuild
psql -U postgres < salon.sql

# Example
https://forum.freecodecamp.org/t/salon-appointment-scheduler-does-whats-asked-but-does-not-pass-tests/622805