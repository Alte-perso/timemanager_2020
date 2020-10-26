#!/bin/bash

if [ $# -eq 1 ]
then
	echo $#
	curl -H "Content-Type: application/json" -X POST -d '{"workingtime":{"start":"2020-03-03 03:03:03","end":"2020-04-04 04:04:04"}}' http://localhost:4000/api/workingtimes/$1

else
	echo "Error: put user ID as argument"
fi
