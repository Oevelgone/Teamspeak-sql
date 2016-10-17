#!/bin/bash

set -e

until mysql -h"$TS_DB_HOST" -P"$TS_DB_PORT" -u"$TS_DB_USER" -p"$TS_DB_PASSWORD" -e "use $TS_DB_NAME"; do
    >&2 echo "SQL is unavailable - sleeping"
    sleep 3
done

# Updating SQL connections in inifile from Environment
sed -i -e "s/host=127.0.0.1/host=$TS_DB_HOST/g" /opt/teamspeak/ts3db_sql.ini
sed -i -e "s/port=3306/port=$TS_DB_PORT/g" /opt/teamspeak/ts3db_sql.ini
sed -i -e "s/username=teamspeak/username=$TS_DB_USER/g" /opt/teamspeak/ts3db_sql.ini
sed -i -e "s/password=password/password=$TS_DB_PASSWORD/g" /opt/teamspeak/ts3db_sql.ini
sed -i -e "s/database=teamspeak/database=$TS_DB_NAME/g" /opt/teamspeak/ts3db_sql.ini

# Running server
/opt/teamspeak/ts3server_minimal_runscript.sh inifile=/opt/teamspeak/ts3server.ini
