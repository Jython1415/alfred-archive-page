#!/bin/zsh --no-rcs

/usr/bin/sqlite3 "${db_metadata}" <<SQL
INSERT OR REPLACE INTO metadata (key, value) VALUES
     ('version', '0.2.2');
SQL

exit 0
