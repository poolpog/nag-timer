#!/usr/bin/env bash
set -x

# Opens TRACKER_FILE in perferred editor for manual edits
# TODO
#   * use jq to validate JSON syntax after editing and deny edit of syntax failed

cd $( dirname $0 )
CWD=$( pwd -P )
source "${CWD}/../lib/config.inc"

if [[ -z "${EDITOR}" ]]; then
    EDITOR="vim"
fi

${EDITOR} ${TRACKER_FILE}
