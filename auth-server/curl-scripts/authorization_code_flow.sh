client_id="sbHWUpn1SMvw54tel57UagJp"
client_secret="OofgDPXaeacYY28sk4xRrxLPwdAVTmEwkuav5I6cfPJqgARE"

#open "http://127.0.0.1:5000/oauth/authorize?response_type=code&client_id=${client_id}&scope=profile"


code="z5VG6Wc7t1ZjX5KTFpdD62OnM0DaerYVJRadlc6PmPtAIJwe"

response=$(curl -u ${client_id}:${client_secret} -XPOST http://127.0.0.1:5000/oauth/token -F grant_type=authorization_code -F scope=profile -F code=${code})
echo "$response" | jq .

# Get data
access_token=$(echo "$response" | jq -r .access_token)
response=$(curl -H "Authorization: Bearer ${access_token}" http://127.0.0.1:5000/api/me)
echo "$response" | jq .