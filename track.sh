#!/usr/bin/env bash
set -x

cd $( dirname $0 )
CWD=$( pwd -P )
source "${CWD}/config.inc"

if [[ ! -f "${TRACKER_FILE}" ]]; then
    touch "${TRACKER_FILE}"
fi


# Kill existing trackers and have them output the default tracker value
osascript  -e "repeat" \
    -e 'tell application "Finder" to tell process "System Events"' \
    -e 'click button "Cancel" of window "NAGTRACKER"' \
    -e 'end tell' \
    -e "end repeat"

sleep 1

./nag.sh | tee -a "${TRACKER_FILE}"
