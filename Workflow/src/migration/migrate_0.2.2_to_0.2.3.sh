#!/bin/zsh --no-rcs

# If "db_data" is not set, error
if [[ -z "${db_data}" ]]; then
    echo "Error: db_data is not set" >&2
    exit 1
fi

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
    response_code_recieved INTEGER NOT NULL,
    response_code INTEGER NOT NULL,
    response_body TEXT NOT NULL,
    response_time_ms INTEGER NOT NULL,
    FOREIGN KEY (url_id) REFERENCES url (url_id)
);

SQL

# If the SQL command failed, error
if [[ $? -ne 0 ]]; then
    # Delete the database file if it exists
    if [[ -f "${db_data}" ]]; then
        rm "${db_data}"
    fi

    echo "Error: Failed to initialize database" >&2
    exit 1
fi

# If the SQL command succeeded, exit

exit 0
