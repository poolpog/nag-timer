#!/usr/bin/env bash
set -x

cd $( dirname $0 )
CWD=$( pwd -P )
source "${CWD}/config.inc"

WHICH="${1:-CSV}"
SUB_PATH=$( echo "${CWD}/track.sh" | sed 's/\//\\\//g' )

set +x
if [[ "${WHICH}"  ==  "CSV" ]]; then
    echo "Date,Activity,Time elapsed"
    jq -r -s  '.[]|"\(.time_end),\(.activity),\( (( .time_end_s| tonumber )  - ( .time_start_s| tonumber ) ) / 60 ) min"'  "${TRACKER_FILE}"  | sort -n
else
    jq -r -s  '.[]|"Date:\(.time_end)|:Activity:\(.activity)|Time elapsed: \( (( .time_end_s| tonumber )  - ( .time_start_s| tonumber ) ) / 60 ) min"'  "${TRACKER_FILE}"  | sort -n
fi

