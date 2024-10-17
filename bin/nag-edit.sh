#!/usr/bin/env bash
# Opens TRACKER_FILE in perferred editor for manual edits
# TODO
#   * use jq to validate JSON syntax after editing and deny edit of syntax failed

if [[ "${DEBUG}" ]]; then
    set -x
fi

cd $( dirname $0 )
CWD=$( pwd -P )
source "${CWD}/../lib/common.sh"

if [[ -z "${EDITOR}" ]]; then
    EDITOR="vim"
fi

${EDITOR} ${TRACKER_FILE}
