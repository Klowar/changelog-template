#!/bin/bash

template_folder=template
changes_folder=changes
changelog_file=changelog.md
# echo "$versions"
# echo "$version"
# echo "$change"

for entry in $(ls .); do
	if [ $entry != $template_folder ] && [ -d "$entry" ]; then
		# copy template
		touch "$entry/$changelog_file"
		echo "# Changelog" >"$entry/$changelog_file"
	fi
done

# Version section
for entry in $(ls .); do
	change_changelog="$entry/$changelog_file"
	if [ $entry != $template_folder ] && [ -d "$entry" ]; then
		echo "## Versions" >> "$change_changelog"
		for version in $(ls .); do
			if [ $version != $template_folder ] && [ -d "$version" ]; then
				( source template/changelog.env; echo $version_line ) >> "$change_changelog"
			fi
		done
	fi
done

# Changes section
for entry in $(ls .); do
	change_changelog="$entry/$changelog_file"
	change_folder="$entry/$changes_folder"
	if [ $entry != $template_folder ] && [ -d "$entry" ] && [ -d "$change_folder" ]; then
		echo "## Changes" >> "$change_changelog"
		for change in $(ls "$entry/$changes_folder"); do
			cat "$change_folder/$change" >> "$change_changelog"
		done
	fi
done
