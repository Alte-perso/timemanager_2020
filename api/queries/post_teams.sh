#!/bin/bash

if [ $# -eq 1 ]
then
	echo $#
	curl -H "Content-Type: application/json" -X POST -d '{"team":{"name":"test_team-1"}}' http://localhost:4000/api/teams/$1

else
	echo "Error: put user ID as argument"
fi
