#!/bin/bash
# This Script will try to return the Java Thread belonging to the specified LWPID (Light Weight ProcessID).
# Therefore it will find the PID (processID) of the specified LWPID, create a threaddump of this PID 
# (which is assumed to be a JVM process) and grep the threaddump for the hexadecimal representation of the LWPID.
# 
# Usage: sudo -u <APPLICATION_SHELL_USER> /path/to/getJavaThreadStack.sh <LWPID>

# Path to the "jstack" utility
JSTACK=jstack
LWPID=$1

# If LWPID hasn't been specified, get the LWPID of the thread consuming the most CPU (via 'top -H')
if [[ -z "$LWPID" ]]; then
	LWPID=$(top -n1 -H | grep -m1 java | perl -pe 's/\e\[?.*?[\@-~] ?//g' | cut -f1 -d' ')
fi

# hexadecimal presentation of the LWPID
NID=$(printf '%x' $LWPID)

# get the process listing containing the current LWPID ('grep java' is necessary because grep on the process list always also finds the 'grep process' itself)
COMMAND_LINE=$(ps -efL | grep $LWPID | grep java)
# print out the command line so the user knows which OS process actually contains the specified LWPID
echo $COMMAND_LINE

# retrieve the PID (processID) from the COMMAND_LINE
PID=$(echo $COMMAND_LINE | perl -pe 's/\e\[?.*?[\@-~] ?//g' | awk '{print $2}')

# get the thread dump of the JVM and grep for the hexadecimal presentation of the LWPID (a.k.a. NID)
$JSTACK $PID | grep -A500 $NID | grep -m1 '^$' -B 500
