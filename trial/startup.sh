#!/bin/bash

echo "Waiting for MySQL to start..."
sleep 15

INIT_FLAG_FILE="/var/lib/mysql/.sql_initialized"

if [ -f "$INIT_FLAG_FILE" ]; then
    echo "Database already initialized (flag file exists), skipping SQL import..."
else
    echo "Database not initialized, starting SQL import process..."

    if [ -f "/app/sql.zip" ]; then
        echo "Found sql.zip, extracting..."
        cd /app
        unzip -o sql.zip
        echo "Successfully extracted sql.zip"
    else
        echo "No sql.zip found in /app directory"
    fi

    if [ -d "/app/sql" ]; then
        echo "Found sql directory, importing SQL files..."
        for sql_file in /app/sql/*.sql; do
            if [ -f "$sql_file" ]; then
                echo "Importing $sql_file..."
                mysql -h mysql -P 3306 -u mysql -pmysql analyzer_database < "$sql_file"
                if [ $? -eq 0 ]; then
                    echo "Successfully imported $sql_file"
                else
                    echo "Failed to import $sql_file"
                fi
            fi
        done
        touch "$INIT_FLAG_FILE"
        sleep 60
        echo "All SQL files imported successfully"
    else
        echo "No sql directory found, skipping SQL import"
    fi

    echo "Startup script completed"
fi