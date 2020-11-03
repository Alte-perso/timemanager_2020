#!/bin/bash

curl -H "Content-Type: application/json" -X POST -d '{"user":{"username":"test1","email":"test1@test.com","password":"12345678"}}' http://localhost:4000/api/users
curl -H "Content-Type: application/json" -X POST -d '{"user":{"username":"test2","email":"test2@test.com","password":"12345678"}}' http://localhost:4000/api/users
curl -H "Content-Type: application/json" -X POST -d '{"user":{"username":"test3","email":"test3@test.com","password":"12345678"}}' http://localhost:4000/api/users

