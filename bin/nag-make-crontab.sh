#!/usr/bin/env bash

cd $( dirname $0 )
CWD=$( pwd -P )
source "${CWD}/../lib/config.inc"

WHICH="${1:-CRON}"
SUB_PATH=$( echo "${CWD}/track.sh" | sed 's/\//\\\//g' )

if [[ "${WHICH}"  ==  "LAUNCHCTL" ]]; then
    sed 's/PATH_TO_NAG_TIMER/'"${SUB_PATH}"'/' nag-launchctl-template.plist
else
    # This isn't perfect; it doesn't account for crontab variables very well
    OLD="$( crontab -l )"
    NEW="$( sed 's/PATH_TO_NAG_TIMER/ '"${SUB_PATH}"' /' crontab.txt )"
    CRON_VARS="$( printf "%s\n%s\n" "${OLD}" "${NEW}" | grep  '=' | sort | uniq )"
    CRON_ENTRIES="$( printf "%s\n%s\n" "${OLD}" "${NEW}" | grep -v '=' | sort | uniq )"
    echo "${CRON_VARS}"
    echo "${CRON_ENTRIES}"
fi

