# Nag Timer

Currently only works on macOS (uses Osascript to nag you)

Purpose of this timer is a simple dialog pops up every fifteen minutes and asks you what you were working on. Outputs in JSON format to a file in your home dir. There are no timers to reset, nothing to forget, and if you fail to answer, the next time it runs it cancels the last one and enters "Idle".

Why? I found all the timers out there to be as much of a pain as entering time into a time sheet in the first place. 15 minute chunks are granular enough that I can quite accurately review my day and fill in a timesheet at the end of the day, or end of the week.

# Installation

1. Clone this github, e.g.

       git clone https://github.com/poolpog/nag-timer /Users/jsilverman/bin/nag-timer

2. Run make-crontab.sh and pipe to crontab; this adds timer entry for 15 mins

       /Users/jsilverman/bin/nag-timer/make-crontab.sh  2>/dev/null | crontab  -

# TO DO

* Reporting
