#!/bin/bash

# Load variables from .env file
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

# Get access token
response=$(curl -s -u ${CLIENT_ID}:${CLIENT_SECRET} -XPOST http://127.0.0.1:5000/oauth/token -F grant_type=password -F username=${USERNAME} -F password=${PASSWORD} -F scope=profile)
echo "http://127.0.0.1:5000/oauth/token"
echo "$response" | jq .
access_token=$(echo "$response" | jq -r .access_token)

# Get data
user_info=$(curl -s -H "Authorization: Bearer ${access_token}" http://127.0.0.1:5000/api/me)
echo "http://127.0.0.1:5000/api/me"
echo "$user_info" | jq .