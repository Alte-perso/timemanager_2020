#!/bin/bash

curl -H "Content-Type: application/json" -X GET \
http://localhost:4000/api/users \
-c cookies.txt -b cookies.txt -i
