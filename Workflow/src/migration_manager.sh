#!/bin/zsh --no-rcs

# Retrieve stored and current versions
stored_version="${stored_version}"
target_version="${version}"

# Define the sequence of migrations
migrations=(
    ":0.2.2"
    "0.2.1:0.2.2"
    # "0.2.2:0.2.3"
)

# Iterate through migrations and apply necessary ones
for migration in "${migrations[@]}"; do
    from_version="${migration%%:*}"
    to_version="${migration##*:}"

    if [[ "${from_version}" == "${stored_version}" ]]; then
        ./src/migration/migrate_${from_version}_to_${to_version}.sh
        if [[ $? -ne 0 ]]; then
            echo "Migration from $from_version to $to_version failed."
            exit 1
        fi

        # Update stored version after successful migration
        /usr/bin/sqlite3 "${db_metadata}" "UPDATE metadata SET value = '${to_version}' WHERE key = 'version';"

    fi
done

echo -n "success"
