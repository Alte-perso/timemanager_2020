#!/bin/bash

if [ $# -eq 1 ]
then
	echo $#
	curl -H "Content-Type: application/json" -X POST -d '{"clock":{"time":"2020-01-01 01:01:01","status":"true"}}' http://localhost:4000/api/clocks/$1

else
	echo "Error: put user ID as argument"
fi
