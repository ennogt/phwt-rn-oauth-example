#!/bin/bash

# Load variables from .env file
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

# Get authorization code
auth_url="http://127.0.0.1:5000/oauth/authorize?response_type=code&client_id=${CLIENT_ID}&scope=${SCOPE}&redirect_uri=${REDIRECT_URI}"
echo "URL: $auth_url"
open "$auth_url"

# Wait for the user to copy the code from the URL
echo "Enter the code:"
read code

# Get access token
response=$(curl -s -u ${CLIENT_ID}:${CLIENT_SECRET} -XPOST http://127.0.0.1:5000/oauth/token -F grant_type=authorization_code -F scope=${SCOPE} -F code=${code} -F redirect_uri=${REDIRECT_URI})
echo "URL: http://127.0.0.1:5000/oauth/token"
echo "$response" | jq .
access_token=$(echo "$response" | jq -r .access_token)

# Get data
response=$(curl -s -H "Authorization: Bearer ${access_token}" http://127.0.0.1:5000/api/me)
echo "URL: http://127.0.0.1:5000/api/me"
echo "$response" | jq .