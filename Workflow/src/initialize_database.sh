#!/bin/zsh --no-rcs

# If "db_metadata" is not set, error
if [[ -z "${db_metadata}" ]]; then
  echo "Error: db_metadata is not set" >&2
  exit 1
fi

echo "Initializing database: ${db_metadata}"

/usr/bin/sqlite3 "${db_metadata}" <<SQL

CREATE TABLE IF NOT EXISTS metadata (key TEXT PRIMARY KEY, value TEXT);

INSERT OR REPLACE INTO metadata (key, value) VALUES
    ('execution_count', '0')
    ('version', '0.2.2');

SQL
