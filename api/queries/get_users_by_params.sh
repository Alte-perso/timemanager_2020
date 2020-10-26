#!/bin/bash

if [ $# -eq 1 ]
then
	echo $#
	curl -H "Content-Type: application/json" -X GET http://localhost:4000/api/users?$1
else
	echo "Error: put user params as (single string format)"
fi
