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

set +x
echo '"StartTime","EndTime","Activity"'
jq -r \
    '[.time_start,.time_end,.activity] | @csv' \
    "${TRACKER_FILE}"  | \
    sort -n

