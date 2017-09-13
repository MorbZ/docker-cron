#!/bin/bash
cronfile=/etc/cron.d/cron
cat /dev/null > $cronfile
for cronvar in ${!CRON_*}; do
	cronvalue=${!cronvar}
	echo "Installing $cronvar"
	echo "$cronvalue >> /var/log/cron.log 2>&1" >> $cronfile
done
echo >> $cronfile # Newline is required
