#!/bin/bash

# Copyright (c) 2019 SUSE Linux GmbH
#
# This file is part of susemanager-cloud-setup.
#
# susemanager-cloud-setup is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at your
# option) any later version.
#
# susemanager-cloud-setup is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
#
# You should have received a copy of the GNU General Public License

AZUREMETADATA=$(type -p azuremetadata)
EC2METADATA=$(type -p ec2metadata)
GCEMETADATA=$(type -p gcemetadata)
LOGFILE=/var/log/susemanager_firstuser.log

# init log
touch $LOGFILE
chmod 600 $LOGFILE
exec &> >(tee -a $LOGFILE)

echo "$0 started `date`"

if [[ -n $AZUREMETADATA ]]; then
    public_hostname=$($AZUREMETADATA --cloud-service --bare)
    admin_pass=$($AZUREMETADATA --instance-name --bare)-suma
fi
if [[ -n $EC2METADATA && -z $public_hostname ]]; then
    public_hostname=$($EC2METADATA --public-hostname)
    admin_pass=$($EC2METADATA --instance-id)
fi
if [[ -n $GCEMETADATA && -z $public_hostname ]]; then
    public_hostname=`host $($GCEMETADATA --query instance --external-ip) | sed -r -e 's/(.* )(.*)./\2/'`
    admin_pass=$($GCEMETADATA --query instance --id)
fi

# fallbacks
if [[ -z $public_hostname ]]; then
    public_hostname=$(hostname -f)
    echo "Warning: Could not detect cloud framework or public hostname. Using '$public_hostname'."
fi
if [[ -z $admin_pass ]]; then
    admin_pass=$(dd if=/dev/random bs=1 |tr -cd '[a-zA-Z0-9!@#$%^&]' |head -c 12)
    echo "Warning: Could not detect cloud framework. Using random admin password."
fi

if [[ -f /etc/motd.finished ]]; then
    mv /etc/motd.finished /etc/motd

    # Update motd message now that the service is running
    echo "You can access SUSE Manager via https://$public_hostname" >> /etc/motd
fi

function listening {
    local check=0
    while true; do
        # check whether we can connect to https
        exec 2>&1 6<>/dev/tcp/127.0.0.1/443
        local port_open=$?
        exec 6>&- # close output connection
        exec 6<&- # close input connection

        # wait for a bit for apache to be available
        if [[ $port_open -ne 0 && $check -lt 15 ]]; then
            check=$((check + 1))
            sleep 2
            continue
        fi

        return $port_open
    done
}

if listening; then
    echo "Creating SUSE Manager Admin user (password '$admin_pass')"
    curl -s -S -X POST \
        -k "https://localhost/rhn/newlogin/CreateFirstUser.do" \
        -d "submitted=true" \
        -d "login=admin" \
        -d "desiredpassword=$admin_pass" \
        -d "desiredpasswordConfirm=$admin_pass" \
        -d "firstNames=Administrator" \
        -d "lastName=McAdmin" \
        -d "email=root@localhost" \
        -d "prefix=Mr." \
        -d "orgName=Organisation"
    ret=$?
else
    echo "Warning: http server not running, cannot create admin user."
    ret=1
fi

echo "$0 done `date`"

exit $ret
