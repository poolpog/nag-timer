#!/usr/bin/env bash
set -x

cd $( dirname $0 )
CWD=$( pwd -P )
source "${CWD}/config.inc"

WHICH="${1:-CRON}"
SUB_PATH=$( echo "${CWD}/track.sh" | sed 's/\//\\\//g' )

if [[ "${WHICH}"  ==  "LAUNCHCTL" ]]; then
    sed 's/PATH_TO_NAG_TIMER/'"${SUB_PATH}"'/' nag-launchctl-template.plist
else
    ( crontab -l; sed 's/PATH_TO_NAG_TIMER/'"${SUB_PATH}"'/' crontab.txt ) | sort | uniq
fi

