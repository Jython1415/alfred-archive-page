#!/bin/zsh --no-rcs

# Get the line 5th from the bottom of Workflow/info.plist
info_line=$(/usr/bin/tail -n 5 Workflow/info.plist | /usr/bin/head -n 1)

# Extract the version number from the line
# 	<string>0.2.1</string>
info_version=$(echo "$info_line" | sed -n 's/.*<string>\(.*\)<\/string>.*/\1/p')

# Get the line 4th from the bottom of Workflow/src/initialize_database.sh
init_line=$(/usr/bin/tail -n 3 Workflow/src/initialize_database.sh | /usr/bin/head -n 1)

# Extract the version number from the line
#     ('version', '0.2.1');
init_version=$(echo "${init_line}" | /usr/bin/sed -E "s/.*'version', '(.*)'.*/\1/")

# Compare the version numbers
if [[ "${info_version}" == "${init_version}" ]]; then
    echo "The version numbers match: ${info_version}"
    exit 0
else
    echo "The version numbers do not match:"
    echo "info.plist: ${info_version}"
    echo "initialize_database.sh: ${init_version}"
    exit 1
fi
