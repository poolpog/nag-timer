#!/usr/bin/env bash
if [[ "${DEBUG}" ]]; then
    set -x
fi

cd $( dirname $0 )
CWD=$( pwd -P )
source "${CWD}/../lib/common.sh"

WHICH="${1:-CRON}"
SUB_PATH=$( echo "${CWD}/nag-track.sh" | sed 's/\//\\\//g' )

if [[ "${WHICH}"  ==  "LAUNCHCTL" ]]; then
    sed 's/PATH_TO_NAG_TIMER/'"${SUB_PATH}"'/' nag-launchctl-template.plist
else
    # This isn't perfect; it doesn't account for crontab variables very well
    CRONTAB="$( sed 's/PATH_TO_NAG_TIMER/ '"${SUB_PATH}"' /' ../lib/crontab.txt )"
    echo "${CRON_VARS}"
    echo "${CRON_ENTRIES}"
    echo "${CRONTAB}"
fi

