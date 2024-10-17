#!/usr/bin/env bash
# This is what should go into a cron job
# This script calls nag.sh and directs the output to a log file
if [[ "${DEBUG}" ]]; then
    set -x
fi

cd $( dirname $0 )
CWD=$( pwd -P )
source "${CWD}/../lib/common.sh"

if [[ ! -f "${TRACKER_FILE}" ]]; then
    touch "${TRACKER_FILE}"
fi


function kill_existing {
    if [[ ${OS} == "Darwin" ]]; then
        osascript  -e "repeat" \
            -e 'tell application "Finder" to tell process "System Events"' \
            -e 'click button "Cancel" of window "NAGTRACKER"' \
            -e 'end tell' \
            -e "end repeat"
    elif [[ ${OS} == "Linux" ]]; then
        PID=$( ps -ef | grep '[z]enity.*NAGTRACKER' | awk '{print $2}' )
        if [[ -n "${PID}" ]]; then
            kill ${PID}
        fi
    fi
}

kill_existing
sleep 1
./nag.sh | tee -a "${TRACKER_FILE}"
