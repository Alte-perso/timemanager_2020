#!/bin/bash

curl -H "Content-Type: application/json" -X POST -d '{"user":{"username":"zzz","email":"zzz@zzz.com","password":"zzz"}}' http://localhost:4000/api/users

