#!/usr/bin/env bash
CWD=$( pwd -P )
if [[ ! -f "${CWD}/../lib/config.inc" ]]; then
    cp "${CWD}/../lib/config.inc.dist" "${CWD}/../lib/config.inc"
fi
source "${CWD}/../lib/config.inc"
OS=$( uname -s )
NOW_DAY=$( date '+%m/%d/%Y %H' )
