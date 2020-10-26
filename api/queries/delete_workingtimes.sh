#!/bin/bash

if [ $# -eq 1 ]
then
	echo $#
	curl -H "Content-Type: application/json" -X DELETE http://localhost:4000/api/workingtimes/$1
else
	echo "Error: put workingtime ID as argument"
fi
