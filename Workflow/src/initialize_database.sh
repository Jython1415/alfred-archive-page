#!/bin/zsh --no-rcs

# If "db_metadata" is not set, error
if [[ -z "${db_metadata}" ]]; then
    echo "Error: db_metadata is not set" >&2
    exit 1
fi

# If "db_data" is not set, error
if [[ -z "${db_data}" ]]; then
    echo "Error: db_data is not set" >&2
    exit 1
fi

echo "Initializing database: ${db_metadata}"

/usr/bin/sqlite3 "${db_metadata}" <<SQL

CREATE TABLE IF NOT EXISTS metadata (key TEXT PRIMARY KEY, value TEXT);

INSERT OR REPLACE INTO metadata (key, value) VALUES
    ('execution_count', '0')
    ('version', '${version}');

SQL

/usr/bin/sqlite3 "${db_data}" <<SQL

CREATE TABLE IF NOT EXISTS url (
    url_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    raw_url TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS request (
    request_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    url_id INTEGER NOT NULL,
    request_time TEXT NOT NULL,
    request_timeout_limit_sec INTEGER NOT NULL,
    workflow_version TEXT NOT NULL,
    response_timed_out INTEGER NOT NULL,
    response_code INTEGER,
    response_url TEXT,
    response_body TEXT,
    response_wait_ms INTEGER NOT NULL,
    FOREIGN KEY (url_id) REFERENCES url (url_id)
);

SQL

echo -n "success"
