#!/bin/bash

curl -H "Content-Type: application/json" -X POST -d '{"user":{"username":"zzz","email":"zzz@zzz.com","password":"zzzzzzzz","role":"manager"}}' http://localhost:4000/api/users

