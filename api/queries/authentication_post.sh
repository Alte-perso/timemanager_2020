#!/bin/bash

curl -H "Content-Type: application/json" -X POST \
-d '{"auth":{"username":"zzz","password":"zzzzzzzz"}}' \
http://localhost:4000/auth \
-c cookies.txt -b cookies.txt -i
