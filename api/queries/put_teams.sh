#!/bin/bash

if [ $# -eq 1 ]
then
	echo $#
	curl -H "Content-Type: application/json" -X PUT -d '{"user":{"username":"test","email":"test@test.com"}}' http://localhost:4000/api/users/$1
else
	echo "Error: put user ID as argument"
fi
