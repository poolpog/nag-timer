#!/usr/bin/env bash

# for now, use like this:
#
#    ./report.sh  | column -s',' -t | grep 2020-04-23
#
if [[ "${DEBUG}" ]]; then
    set -x
fi

cd $( dirname $0 )
CWD=$( pwd -P )
source "${CWD}/../lib/common.sh"

if ! ( jq --version >/dev/null 2>&1 ) ; then
    echo "ERROR: Reports need jq installed"
    echo "Example (using Homebrew):"
    echo
    echo "brew install jq"
    echo
    exit 1
fi

FORMAT="${1:-CSV}"
DAY="${2:-ALL}"

set +x
if [[ "${FORMAT}"  ==  "CSV" ]]; then
    echo "Date,Activity,Time elapsed"
    jq -r -s \
        '.[] | "\(.time_end),\(.activity),\( (( .time_end_s| tonumber )  - ( .time_start_s| tonumber ) ) / 60 ) min"' \
        "${TRACKER_FILE}"  | \
        sort -n
else
    jq -r -s \
        '.[] | "Date:\(.time_end)|:Activity:\(.activity)|Time elapsed: \( (( .time_end_s| tonumber )  - ( .time_start_s| tonumber ) ) / 60 ) min"' \
        "${TRACKER_FILE}"  | \
        sort -n
fi

