#!/bin/bash

if [ $# -eq 1 ]
then
	echo $#
	curl -H "Content-Type: application/json" -X PUT -d '{"workingtime":{"start":"2020-06-06 06:06:06","end":"2020-07-07 07:07:07"}}' http://localhost:4000/api/workingtimes/$1
else
	echo "Error: put workingtime ID as argument"
fi
