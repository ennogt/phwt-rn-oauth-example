client_id="wSuQZ1VZ8nxn0UiU9CqFqH9B"
client_secret="KMGZZollPof6iMZRco2KugeVR5XutTPbAODnmv4cHMZTgCpU"
username="testuser"

# Response: {"access_token": "vMbM20wil0z3fev3333KBMpuqig5PoFL0TTPkrunyw", "expires_in": 864000, "refresh_token": "CN48tuH3IWc5dzd4JbA4UWyMIQelTV0joTMLcBy7tF0Ajv7c", "scope": "profile", "token_type": "Bearer"}

response=$(curl -u ${client_id}:${client_secret} -XPOST http://127.0.0.1:5000/oauth/token -F grant_type=password -F username=${username} -F password=valid -F scope=profile)
echo "$response" | jq .

# Get data
access_token=$(echo "$response" | jq -r .access_token)
response=$(curl -H "Authorization: Bearer ${access_token}" http://127.0.0.1:5000/api/me)
echo "$response" | jq .