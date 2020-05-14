#!/usr/bin/env bash
set -x

cd $( dirname $0 )
CWD=$( pwd -P )
source "${CWD}/../lib/config.inc"

read -r -d '' OSASCRIPT <<EOF
   tell application "Finder"
   activate
   set retval to text returned of (display dialog "What were you just working on?" default answer "" with title "NAGTRACKER")
   return retval
   end tell
EOF

ACTIVITY="${DEFAULT_ACTIVITY}"

RETVAL=$(osascript -e "${OSASCRIPT}");
if [[ "$?" != 0 ]]; then
    ACTIVITY="TRACKER CANCELLED"
elif [[ -n "${RETVAL}" ]]; then
    ACTIVITY="${RETVAL}"
fi

TIME_END_S=$(  date +%s )
TIME_START_S=$(( TIME_END_S - ( 15 * 60 ) ))
TIME_START=$(  date  -r  "${TIME_START_S}"  "+${DATE_FMT}"  )
TIME_END=$(    date  -r  ${TIME_END_S}      "+${DATE_FMT}"  )

cat <<EOF
{
    "time_start_s": "${TIME_START_S}",
    "time_end_s": "${TIME_END_S}",
    "time_start": "${TIME_START}",
    "time_end": "${TIME_END}",
    "activity": "${ACTIVITY}"
}
EOF
