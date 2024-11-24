#!/bin/zsh --no-rcs

# Get the execution count from the metadata table
execution_count=$(/usr/bin/sqlite3 "${db_metadata}" \
    "SELECT value FROM metadata WHERE key = 'execution_count';")

# Increment the execution count
execution_count=$((execution_count + 1))

# Update the execution count in the metadata table
/usr/bin/sqlite3 "${db_metadata}" <<SQL
INSERT OR REPLACE INTO metadata (key, value) VALUES
     ('execution_count', '${execution_count}');
SQL

cat <<EOF
{
    "alfredworkflow": {
        "variables": {
            "execution_count": "${execution_count}"
        }
    }
}
EOF
