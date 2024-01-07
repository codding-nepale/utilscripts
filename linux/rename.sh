#!/bin/bash

echo "Welcome to the interactive file renaming script by codding-nepal (https://github.com/codding-nepale/utilscripts/)."
echo

read -p "Enter the source folder path (press Enter to use the current folder): " sourceFolder
sourceFolder=${sourceFolder:-.}

read -p "Enter the file extensions you want to rename (separated by a space, e.g., js mjs): " fileExtensions
if [ -z "$fileExtensions" ]; then
    echo "No extensions specified. The script will exit."
    read -p "Press Enter to continue..."
    exit 1
fi

IFS=' ' read -ra extensionsArray <<< "$fileExtensions"
firstExtension="${extensionsArray[0]}"

read -p "Enter folders to exclude (separated by a space, press Enter to skip): " excludeFolders

echo
echo "Renaming in progress..."

for extension in $fileExtensions; do
    find "$sourceFolder" -type f -name "*.$extension" | while read -r file; do
        filename=$(basename "$file")
        dirname=$(dirname "$file")
        newName="$dirname/${filename%.*}.$firstExtension"

        excludeFolder=false
        if [ -n "$excludeFolders" ]; then
            IFS=' ' read -ra folders <<< "$excludeFolders"
            for folder in "${folders[@]}"; do
                if [[ "$dirname" == *"$folder"* ]]; then
                    excludeFolder=true
                    break
                fi
            done
        fi

        if [ "$excludeFolder" != true ]; then
            echo "Renaming \"$file\" to \"$newName\""
            mv "$file" "$newName"
        fi
    done
done

echo
echo "Renaming complete."
read -p "Press Enter to continue..."
