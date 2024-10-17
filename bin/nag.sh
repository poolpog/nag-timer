#!/usr/bin/env bash
if [[ "${DEBUG}" ]]; then
    set -x
fi

cd $( dirname $0 )
CWD=$( pwd -P )
source "${CWD}/../lib/common.sh"

ACTIVITY="${DEFAULT_ACTIVITY}"

function retrieve_value {
    RETVAL=""
    if [[ ${OS} == "Darwin" ]]; then
        read -r -d '' RETVAL <<EOF
           tell application "Finder"
           activate
           set retval to text returned of (display dialog "What were you just working on?" default answer "" with title "NAGTRACKER")
           return retval
           end tell
EOF
    elif [[ ${OS} == "Linux" ]]; then
        # TODO: this needs to detect the display
        export DISPLAY=:1
        RETVAL=$(zenity --timeout=$(( NAG_TIMEOUT )) --entry --title="NAGTRACKER" --text="What were you just working on?")
    fi
    if [[ -n "${RETVAL}" ]]; then
        echo -n "${RETVAL}"
        #RETVAL="TRACKER CANCELLED"
    fi
}

function which_fifteen {
    NOW_H=$( date +%H )
    NOW_M=$( date +%M )
    THIS_QUARTER=""
    for QUARTER in 15 30 45 60 ; do
        WHICH=$(( QUARTER - NOW_M ))
        if [[ ${WHICH} -lt 15 && ${WHICH} -ge 0 ]]; then
            THIS_QUARTER=${QUARTER}
        fi
    done
    echo ${THIS_QUARTER}
}

NAG_VALUE=$(retrieve_value)
if [[ -n "${NAG_VALUE}" ]]; then
    ACTIVITY="${NAG_VALUE}"

    WHICH_QUARTER=$( which_fifteen )
    TIME_START="${NOW_DAY}:$(( WHICH_QUARTER - 15 )):00"
    TIME_END="${NOW_DAY}:$(( WHICH_QUARTER )):00"

    cat <<EOF
    {
        "time_start": "${TIME_START}",
        "time_end": "${TIME_END}",
        "activity": "${ACTIVITY}"
    }
EOF
fi
