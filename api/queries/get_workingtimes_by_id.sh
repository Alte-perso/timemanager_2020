#!/bin/bash

if [ $# -eq 1 ]
then
	echo $#
	curl -H "Content-Type: application/json" -X GET http://localhost:4000/api/workingtimes/$1
else
	echo "Error: put user params as (single string format in form: UID/WID)"
fi
