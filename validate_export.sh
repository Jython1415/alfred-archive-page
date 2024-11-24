#!/bin/zsh --no-rcs

# Get the line 5th from the bottom of Workflow/info.plist
info_line=$(/usr/bin/tail -n 5 Workflow/info.plist | /usr/bin/head -n 1)

# Extract the version number from the line
# 	<string>0.2.1</string>
info_version=$(echo "$info_line" | sed -n 's/.*<string>\(.*\)<\/string>.*/\1/p')

# Extrat the version number from info.plist environment variables
vars_version=$(/usr/bin/xmllint --xpath 'string(//key[.="version"]/following-sibling::string[1])' Workflow/info.plist)

# Get the line 4th from the bottom of Workflow/src/initialize_database.sh
init_line=$(/usr/bin/tail -n 3 Workflow/src/initialize_database.sh | /usr/bin/head -n 1)

# Extract the version number from the line
#     ('version', '0.2.1');
init_version=$(echo "${init_line}" | /usr/bin/sed -E "s/.*'version', '(.*)'.*/\1/")

# Compare the version numbers
if [[ "${info_version}" == "${vars_version}" && "${vars_version}" == "${init_version}" ]]; then
    echo "Version numbers match"
else
    echo "Version numbers do not match"
    echo "info_version: ${info_version}"
    echo "vars_version: ${vars_version}"
    echo "init_version: ${init_version}"
fi
