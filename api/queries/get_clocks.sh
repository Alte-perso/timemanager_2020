#!/bin/bash

if [ $# -eq 1 ]
then
	echo $#
	curl -H "Content-Type: application/json" -X GET http://localhost:4000/api/clocks/$1
else
	echo "Error: put user ID as argument"
fi
