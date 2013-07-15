#!/bin/bash
# This script can be used to grep for the occurrence of a pattern in a logfile which exists on several remote hosts.

MY_HOSTS=( host1.example.com host2.example.com host3.example.com )

for PKG in ${MY_HOSTS[@]}
do
	# the location of the logfile on the remote system
	PATH="/opt/packages/$PKG/logs/jboss?/server.log";
	/usr/bin/ssh ${PKG}k "grep -HoE $1 $PATH";
done
