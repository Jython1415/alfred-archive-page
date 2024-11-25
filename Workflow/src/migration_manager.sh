#!/bin/zsh --no-rcs

# Create a temporary file to collect debug information to output at the end
debug_file=$(mktemp)
# Ensure the debug file is removed on exit
trap 'rm -f "${debug_file}"' EXIT

# Retrieve stored and current versions
stored_version="${stored_version}"
target_version="${version}"
echo "Stored version: ${stored_version}" >> "${debug_file}"
echo "Target version: ${target_version}" >> "${debug_file}"


# Define the sequence of migrations
migrations=(
    ":0.2.2"
    "0.2.1:0.2.2"
    "0.2.2:0.2.3"
)
echo "Migrations: ${migrations[@]}" >> "${debug_file}"

# Compares two version strings, ver1 and ver2
# Precondition: arg1 and arg2 are in the format "major.minor.patch"
# Returns 1 if arg1 is less than or equal to arg2, 0 otherwise
function less_or_equal_version() {
    local ver1="${1}"
    local ver2="${2}"

    # Split the version strings
    local ver1_major="${ver1%%.*}"
    local ver1_minor="${ver1#*.}"
    local ver1_patch="${ver1_minor#*.}"
    ver1_minor="${ver1_minor%%.*}"
    local ver2_major="${ver2%%.*}"
    local ver2_minor="${ver2#*.}"
    local ver2_patch="${ver2_minor#*.}"
    ver2_minor="${ver2_minor%%.*}"

    # Compare major, minor, and patch versions
    if [[ "${ver1_major}" -lt "${ver2_major}" ]]; then
        echo -n 1
        exit 0
    elif [[ "${ver1_major}" -eq "${ver2_major}" ]]; then
        if [[ "${ver1_minor}" -lt "${ver2_minor}" ]]; then
            echo -n 1
            exit 0
        elif [[ "${ver1_minor}" -eq "${ver2_minor}" ]]; then
            if [[ "${ver1_patch}" -le "${ver2_patch}" ]]; then
                echo -n 1
                exit 0
            fi
        fi
    fi

    echo -n 0
}

# Iterate through migrations and apply necessary ones
for migration in "${migrations[@]}"; do
    echo "Checking migration: ${migration}" >> "${debug_file}"
    from_version="${migration%%:*}"
    to_version="${migration##*:}"
    echo "From version: ${from_version}" >> "${debug_file}"
    echo "To version: ${to_version}" >> "${debug_file}"

    # Whether the from_version matches the current stored_version
    if [[ "$from_version" == "$stored_version" ]]; then
        valid_entry=1
    else
        valid_entry=0
    fi
    echo "Valid entry: ${valid_entry}" >> "${debug_file}"
    # Whether the to_version is less than or equal to the target_version
    valid_exit=$(less_or_equal_version $to_version $target_version)
    echo "Valid exit: ${valid_exit}" >> "${debug_file}"

    if [[ "$valid_entry" =~ ^[0-9]+$ ]] && [[ "$valid_exit" =~ ^[0-9]+$ ]]; then
        valid_migration=$(($valid_entry && $valid_exit))
    else
        echo "Invalid entry or exit version" >> "${debug_file}"
        cat ${debug_file}
        exit 1
    fi

    valid_migration=$(($valid_entry && $valid_exit))
    echo "Valid migration: ${valid_migration}" >> "${debug_file}"

    if [[ $valid_migration -eq 1 ]]; then
        echo "Applying migration from $from_version to $to_version" >> "${debug_file}"
        migration_output=$(./src/migration/migrate_${from_version}_to_${to_version}.sh)
        migration_error=$?
        echo "Migration output: ${migration_output}" >> "${debug_file}"
        echo "Migration error: ${migration_error}" >> "${debug_file}"
        if [[ migration_error -ne 0 ]]; then
            echo "Migration from $from_version to $to_version failed." >> "${debug_file}"
            
            cat <<EOJSON
{
    "alfredworkflow" : {
        "arg" : "error",
        "variables" : {
            "migration_manager_debug_output" : $(jq -Rs '.' < "$debug_file"),
            "stored_version" : "${stored_version}"
        }
    }
}
EOJSON

            exit 1
        fi

        # Update stored version after successful migration
        echo "Updating stored version to $to_version" >> "${debug_file}"
        stored_version=$to_version
        /usr/bin/sqlite3 "${db_metadata}" "UPDATE metadata SET value = '${to_version}' WHERE key = 'version';"
    fi
done

cat <<EOJSON
{
    "alfredworkflow" : {
        "arg" : "success",
        "variables" : {
            "migration_manager_debug_output" : $(jq -Rs '.' < "$debug_file"),
            "stored_version" : "${stored_version}"
        }
    }
}
EOJSON

exit 0
